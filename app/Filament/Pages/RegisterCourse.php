<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Hidden;
use Filament\Forms\Components\Grid; // Needed for Grid layout
use Filament\Forms\Form;
use Filament\Forms\Get; // Needed for conditional logic
use Filament\Forms\Set; // Needed for updating other fields
use App\Models\PersonalInfo; // Your student info model
use App\Models\User; // Your user model
use App\Models\Course; // Your course model
use App\Models\Subject; // Your subject model (if applicable)
use App\Models\CourseFee; // Your course fee model (adjust logic as needed)
use App\Models\Payment; // Your payment model
use App\Models\Enrollment; // Your enrollment model (linking student-course)
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash; // Needed for password hashing
use Illuminate\Support\Str; // Needed for random password generation
use Filament\Notifications\Notification;
use Carbon\Carbon;
use Filament\Actions\Action; // Needed for form actions


class RegisterCourse extends Page
{
    // --- Navigation Settings ---
    protected static ?string $navigationIcon = 'heroicon-o-document-plus';
    protected static ?string $navigationLabel = 'Đăng ký';
    protected static ?string $title = 'Đăng ký Khóa học';
    protected static ?int $navigationSort = 1;
    // --- End Navigation Settings ---

    protected static string $view = 'filament.pages.register-course'; // Default view name

    // Form data state
    public ?array $data = [];
    // Holds the ID of the found student (if any)
    protected ?string $foundStudentId = null;

    public function mount(): void
    {
        // Initialize form with default values if necessary
        $this->form->fill();
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Tìm kiếm học viên')
                    ->schema([
                        TextInput::make('student_search')
                            ->label('Tìm kiếm (SĐT, Email hoặc Mã HV)')
                            ->live(debounce: 500)
                            ->afterStateUpdated(function (Set $set, ?string $state) {
                                $this->foundStudentId = null;
                                $set('existing_student_id', null);
                                $set('student_name_placeholder', null);

                                if (filled($state)) {
                                    $student = PersonalInfo::where('phone', $state)
                                                        ->orWhere('email', $state)
                                                        ->orWhere('identitynumber', $state)
                                                        // ->orWhere('student_code', $state) // Uncomment if you have a student code
                                                        ->first();

                                    if ($student) {
                                        $this->foundStudentId = $student->id;
                                        $set('existing_student_id', $student->id);
                                        $set('student_name_placeholder', $student->name . ' - ' . $student->phone);
                                        // Maybe fill some default info if needed
                                    }
                                }
                            }),
                        Hidden::make('existing_student_id'), // Store found student ID
                        Placeholder::make('student_name_placeholder')
                             ->label('Học viên tìm thấy')
                             ->content(fn (?string $state): string => $state ?? '---') // Show placeholder content
                             ->hidden(fn (Get $get): bool => blank($get('existing_student_id'))), // Hide if no student found
                    ]),

                Section::make('Thông tin học viên mới')
                    ->schema([
                        // Use Grid for better layout of new student info
                        Grid::make(['default' => 1, 'md' => 2]) // 1 col on small, 2 on medium+
                            ->schema([
                                Grid::make(3)
                                    ->schema([
                                        TextInput::make('identitynumber')
                                            ->label('CCCD')
                                            ->required()
                                            ->mask('999999999999')
                                            ->rule('regex:/^\d{12}$/')
                                            ->unique(PersonalInfo::class, 'identitynumber', ignoreRecord: true)
                                            ->live(debounce: 500)
                                            ->afterStateUpdated(function (Set $set, ?string $state) {
                                                // Chỉ cập nhật ô Ngày sinh (vì nó hiển thị)
                                                if (self::isValidCCCD($state)) {
                                                    $fullYear = self::getFullYearFromCCCD($state);
                                                    $set('dob', $fullYear ? ($fullYear . '-01-01') : null);
                                                } else {
                                                    $set('dob', null);
                                                }
                                            })
                                            ->columnSpan(1),

                                        TextInput::make('name')
                                            ->label('Họ và Tên')
                                            ->required()
                                            ->maxLength(255)
                                            ->columnSpan(1),
                                        DatePicker::make('dob')
                                            ->label('Ngày sinh')
                                            ,
                                ]),
                                 // Required only if new
                                 Grid::make(2) // Hàng cho Ngày sinh và SĐT
                                 ->schema([
                                    TextInput::make('phone')
                                         ->label('Số điện thoại')
                                         ->required()
                                         ->columnSpan(1),
                                    TextInput::make('email') // Email trên một hàng riêng
                                        ->label('Email')
                                        ->email()
                                        ->required()
                                        ->columnSpan(1)
                                        ->unique(User::class, 'email', ignoreRecord: true)
                                        ->unique(PersonalInfo::class, 'email', ignoreRecord: true),
                                 ]),                                                 
                                    Textarea::make('address')
                                        ->label('Địa chỉ')
                                        ->columnSpanFull(),
                            ]),
                    ])
                    // Show only when search input is filled and no existing student is found
                    ->visible(fn (Get $get): bool => filled($get('student_search')) && blank($get('existing_student_id'))),

                Section::make('Thông tin đăng ký & Thanh toán')
                    ->schema([

                        Grid::make(2) // Grid for Amount Due and Gift
                            ->schema([
                                Select::make('course_id') // Or subject_id depending on your structure
                                ->label('Chọn khóa học/môn học')
                                ->options(Subject::query()->pluck('name', 'id')) // Adjust query if needed
                                ->searchable()
                                ->required()
                                ->live()
                                ->afterStateUpdated(function(Set $set, ?string $state) {
                                    // Auto-fill fee info based on selected course
                                    $courseFee = Subject::where('id', $state)->first(); // Adjust logic as needed
                                    $set('base_fee', $courseFee?->price ?? 0);
                                    $set('discount', $courseFee?->discount ?? 0); // Or let user enter manually
                                    $set('gift', $courseFee?->gift ?? ''); // Or let user enter manually
                                    $this->calculateAmountDue($set); // Recalculate amount due
                                }),
                                
                                TextInput::make('base_fee')
                                ->label('Học phí gốc')
                                ->readOnly(),
                            ]),
                        Grid::make(3) // Grid for Base Fee and Discount
                            ->schema([
                                TextInput::make('discount')
                                    ->label('Giảm giá (số tiền)')
                                    ->live(debounce: 500) // Update calculations live
                                    ->afterStateUpdated(fn(Set $set) => $this->calculateAmountDue($set))
                                    ->default(0),
                                    TextInput::make('amount_due')
                                    ->label('Số tiền cần thu')
                                    ->readOnly(),
                                    TextInput::make('gift')
                                    ->label('Quà tặng (mô tả)'),
                            ]),

                        // Grid::make(2) // Grid for Amount Due and Gift
                        //     ->schema([
                        //         TextInput::make('amount_due')
                        //             ->label('Số tiền cần thu')
                        //             ->readOnly(),
                        //         TextInput::make('gift')
                        //             ->label('Quà tặng (mô tả)'),
                        //     ]),

                        Grid::make(3) // Grid for Amount Paid and Payment Method
                            ->schema([
                                TextInput::make('amount_paid')
                                    ->label('Số tiền thực thu')
                                    ->required()
                                    ->default(0),
                                Select::make('payment_method')
                                    ->label('Hình thức thanh toán')
                                    ->options([
                                        'cash' => 'Tiền mặt',
                                        'bank_transfer' => 'Chuyển khoản',
                                        'card' => 'Thẻ',
                                    ])->required(),
                                DatePicker::make('payment_date')
                                    ->label('Ngày thanh toán')
                                    ->default(now())
                                    ->required(),
                            ]),

                    

                        Textarea::make('notes')
                            ->label('Ghi chú giao dịch')
                            ->columnSpanFull(), // Make textarea take full width
                    ])
                    // Show this section if a student is found OR if user is filling new student form
                    ->visible(fn (Get $get): bool => filled($get('existing_student_id')) || (filled($get('student_search')) && blank($get('existing_student_id')))),
            ])
            ->statePath('data')
            ->model(null); // This is a custom action page, not directly tied to one model
    }

    // Helper function to calculate amount due
    protected function calculateAmountDue(Set $set): void
    {
        // Ensure values are treated as numbers
        $baseFee = (float) ($this->data['base_fee'] ?? 0);
        $discount = (float) ($this->data['discount'] ?? 0);
        $amountDue = $baseFee - $discount;
        // Set the calculated value back to the form field
        $set('amount_due', $amountDue > 0 ? $amountDue : 0);
    }

    // Action handler for form submission
   
    public function create(): void
    {
        $formData = $this->form->getState();

        try {
            DB::transaction(function () use ($formData) {
                $studentPersonalInfoId = null;
                $userId = null; // <-- Khởi tạo userId ở đây
                $tempPassword = null;

                // --- Xử lý tạo học viên MỚI ---
                if (blank($formData['existing_student_id']) && filled($formData['identitynumber'])) {

                    // 1. Tạo User Account
                    $tempPassword = Str::random(8);
                    $newUser = User::create([
                        'name' => $formData['name'], // <-- Sửa: Dùng name thật, không dùng identitynumber
                        'email' => $formData['email'],
                        'password' => Hash::make($tempPassword),
                    ]);
                    $userId = $newUser->id; // <-- Lấy ID User vừa tạo

                    // 2. Tạo Personal Info và liên kết User
                    $dob = $formData['dob'] ?? null; // Lấy dob từ form
                    // Lấy gender và place_of_birth tự động từ CCCD (nếu không ẩn)
                    $gender = $this->getGenderFromCCCD($formData['identitynumber']);
                    $place_of_birth = $this->getProvinceName($this->getProvinceCodeFromCCCD($formData['identitynumber']));

                    $newStudent = PersonalInfo::create([
                        'user_id' => $userId,
                        'identitynumber' => $formData['identitynumber'],
                        'name' => $formData['name'],
                        'phone' => $formData['phone'],
                        'email' => $formData['email'],
                        'dateofbirth' => $dob, // Giả sử cột DB là dateofbirth
                        'address' => $formData['address'],
                        'gender' => $gender, // Lưu gender đã lấy
                        'placeofbirth' => $place_of_birth, // Lưu nơi sinh đã lấy (Giả sử cột DB là placeofbirth)
                    ]);
                    $studentPersonalInfoId = $newStudent->id;

                    // Thông báo mật khẩu tạm... (giữ nguyên)

                } else {
                    // --- Xử lý học viên CŨ ---
                    $studentPersonalInfoId = $formData['existing_student_id'];
                    // *** Sửa: Lấy user_id tương ứng ***
                    $existingPersonalInfo = PersonalInfo::find($studentPersonalInfoId);
                    if ($existingPersonalInfo) {
                         $userId = $existingPersonalInfo->user_id; // <-- Lấy user_id từ PersonalInfo đã có
                    } else {
                         throw new \Exception("Không tìm thấy thông tin cá nhân tồn tại với ID: {$studentPersonalInfoId}");
                    }
                    // *** Hết phần sửa ***
                }

                // --- Đảm bảo $userId hợp lệ ---
                if (is_null($userId)) {
                    throw new \Exception('Không thể xác định User ID hợp lệ.');
                }

                // --- Tạo bản ghi Course (Enrollment) và Payment ---
                if (isset($formData['subject_id'])) { // <-- Sửa: Dùng subject_id từ form

                    // Tạo bản ghi Course (đại diện cho enrollment)
                    $courseEnrollment = Course::create([
                        'user_id' => $userId,             // <-- Sửa: Dùng $userId đã xác định
                        'subject_id' => $formData['subject_id'], // <-- Sửa: Dùng subject_id từ form
                        'enrollment_date' => $formData['payment_date'] ?? now(),
                        'base_fee' => $formData['base_fee'] ?? 0,
                        'discount_amount' => $formData['discount'] ?? 0,
                        'final_amount' => $formData['amount_due'] ?? 0,
                        'gift' => $formData['gift'] ?? null,
                        'status' => 'enrolled', // Trạng thái mặc định ví dụ
                        'payment_status' => 'unpaid', // Trạng thái mặc định ví dụ
                    ]);

                    // Tạo bản ghi Payment
                    Payment::create([
                        'course_id' => $courseEnrollment->id, // Liên kết tới Course enrollment
                        'payment_amount' => $formData['amount_paid'] ?? 0,
                        'payment_date' => $formData['payment_date'] ?? now(),
                        'payment_method' => $formData['payment_method'] ?? null,
                        'note' => $formData['notes'] ?? null,
                    ]);

                     // Cập nhật payment_status nếu cần... (giữ nguyên)
                     if ($courseEnrollment->final_amount <= ($formData['amount_paid'] ?? 0)) {
                        $courseEnrollment->update(['payment_status' => 'paid']);
                    }

                } else {
                    // Xử lý lỗi thiếu môn học
                    throw new \Exception('Thiếu thông tin môn học để tạo đăng ký.');
                }

                // ... (Notifications và Reset form giữ nguyên) ...

            }); // Kết thúc DB Transaction
        } catch (\Exception $e) {
             // ... (Xử lý lỗi và báo Notification giữ nguyên) ...
        }
    }

    // Define the submit action button for the form
    protected function getFormActions(): array
    {
        return [
            Action::make('create')
                ->label('Lưu Đăng Ký')
                ->submit('create'), // Calls the create() method
        ];
    }
    // Bên trong class Resource hoặc Page của bạn

/**
 * Kiểm tra CCCD hợp lệ (12 chữ số).
 */
private function isValidCCCD(?string $cccd): bool
{
    return !is_null($cccd) && strlen($cccd) === 12 && ctype_digit($cccd);
}

/**
 * Lấy mã tỉnh từ CCCD (3 ký tự đầu).
 */
private function getProvinceCodeFromCCCD(?string $cccd): ?string
{
    if (!$this->isValidCCCD($cccd)) { // Dùng $this-> nếu là method trong class
        return null;
    }
    return substr($cccd, 0, 3);
}

/**
 * Lấy giới tính từ CCCD (ký tự thứ 4).
 */
private function getGenderFromCCCD(?string $cccd): ?string
{
     if (!$this->isValidCCCD($cccd)) {
        return null;
    }
    $genderCode = $cccd[3];
    switch ($genderCode) {
        case '0': case '2': return 'Nam';
        case '1': case '3': return 'Nữ';
        default: return null;
    }
}

/**
 * Lấy năm sinh đầy đủ từ CCCD.
 */
private function getFullYearFromCCCD(?string $cccd): ?int
{
    if (!$this->isValidCCCD($cccd)) {
        return null;
    }
    $centuryCode = $cccd[3];
    $yearDigits = substr($cccd, 4, 2); // Ký tự 5 và 6
    switch ($centuryCode) {
        case '0': // TK 20 (19xx)
        case '1':
            return (int)("19" . $yearDigits);
        case '2': // TK 21 (20xx)
        case '3':
            return (int)("20" . $yearDigits);
        default:
            return null; // Mã thế kỷ/giới tính không hợp lệ
    }
}

/**
 * Lấy tên tỉnh từ mã tỉnh (Cần danh sách $provinceMap đầy đủ).
 */
private function getProvinceName(?string $provinceCode): ?string
{
     if (is_null($provinceCode) || strlen($provinceCode) !== 3) {
         return null;
     }
     // *** Quan trọng: Cập nhật đầy đủ map này ***
     $provinceMap = [
        '001' => 'Thành phố Hà Nội', '079' => 'Thành phố Hồ Chí Minh', /* ... thêm tất cả các tỉnh khác ... */
        // Thêm đầy đủ 63 tỉnh/thành phố vào đây
        '002' => 'Tỉnh Hà Giang', '004' => 'Tỉnh Cao Bằng', '006' => 'Tỉnh Bắc Kạn', '008' => 'Tỉnh Tuyên Quang',
        '010' => 'Tỉnh Lào Cai', '011' => 'Tỉnh Điện Biên', '012' => 'Tỉnh Lai Châu', '014' => 'Tỉnh Sơn La',
        '015' => 'Tỉnh Yên Bái', '017' => 'Tỉnh Hoà Bình', '019' => 'Tỉnh Thái Nguyên', '020' => 'Tỉnh Lạng Sơn',
        '022' => 'Tỉnh Quảng Ninh', '024' => 'Tỉnh Bắc Giang', '025' => 'Tỉnh Phú Thọ', '026' => 'Tỉnh Vĩnh Phúc',
        '027' => 'Tỉnh Bắc Ninh', '030' => 'Tỉnh Hải Dương', '031' => 'Thành phố Hải Phòng', '033' => 'Tỉnh Hưng Yên',
        '034' => 'Tỉnh Thái Bình', '035' => 'Tỉnh Hà Nam', '036' => 'Tỉnh Nam Định', '037' => 'Tỉnh Ninh Bình',
        '038' => 'Tỉnh Thanh Hóa', '040' => 'Tỉnh Nghệ An', '042' => 'Tỉnh Hà Tĩnh', '044' => 'Tỉnh Quảng Bình',
        '045' => 'Tỉnh Quảng Trị', '046' => 'Tỉnh Thừa Thiên Huế', '048' => 'Thành phố Đà Nẵng', '049' => 'Tỉnh Quảng Nam',
        '051' => 'Tỉnh Quảng Ngãi', '052' => 'Tỉnh Bình Định', '054' => 'Tỉnh Phú Yên', '056' => 'Tỉnh Khánh Hòa',
        '058' => 'Tỉnh Ninh Thuận', '060' => 'Tỉnh Bình Thuận', '062' => 'Tỉnh Kon Tum', '064' => 'Tỉnh Gia Lai',
        '066' => 'Tỉnh Đắk Lắk', '067' => 'Tỉnh Đắk Nông', '068' => 'Tỉnh Lâm Đồng', '070' => 'Tỉnh Bình Phước',
        '072' => 'Tỉnh Tây Ninh', '074' => 'Tỉnh Bình Dương', '075' => 'Tỉnh Đồng Nai', '077' => 'Tỉnh Bà Rịa - Vũng Tàu',
        '080' => 'Tỉnh Long An', '082' => 'Tỉnh Tiền Giang', '083' => 'Tỉnh Bến Tre', '084' => 'Tỉnh Trà Vinh',
        '086' => 'Tỉnh Vĩnh Long', '087' => 'Tỉnh Đồng Tháp', '089' => 'Tỉnh An Giang', '091' => 'Tỉnh Kiên Giang',
        '092' => 'Thành phố Cần Thơ', '093' => 'Tỉnh Hậu Giang', '094' => 'Tỉnh Sóc Trăng', '095' => 'Tỉnh Bạc Liêu',
        '096' => 'Tỉnh Cà Mau',
     ];
     return $provinceMap[$provinceCode] ?? null;
}
}