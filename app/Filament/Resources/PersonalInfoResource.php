<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PersonalInfoResource\Pages;
use App\Filament\Resources\PersonalInfoResource\RelationManagers;
use App\Models\PersonalInfo;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\DatePicker;
use App\Providers\AppServiceProvider;

use Filament\Forms\Components\Select;
use Illuminate\Validation\Rule;
use App\Models\User;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Carbon\Carbon;

class PersonalInfoResource extends Resource
{
    protected static ?string $model = PersonalInfo::class;

    protected static ?string $navigationLabel = 'Quản lí hồ sơ';
    protected static ?string $pluralLabel = 'Quản lí hồ sơ';
    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Account'; // Tên nhóm bạn muốn

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Grid::make(1)
                ->schema([
                TextInput::make('identitynumber')
                ->label('CMND/CCCD')
                ->required()
                ->type('text') // Tránh hiển thị mũi tên tăng/giảm
                ->placeholder('Nhập 12 số CCCD')
                ->mask('999999999999') // Tạo mặt nạ nhập đúng 12 số
                ->extraInputAttributes([
                    'inputmode' => 'numeric', // Hiển thị bàn phím số trên di động
                    'pattern' => '\d{12}', // Chỉ cho phép nhập đúng 12 chữ số
                    'oninput' => "this.value = this.value.replace(/[^0-9]/g, '')" // Chặn ký tự không phải số ngay khi nhập
                ])
                ->rule('regex:/^\d{12}$/')
                ->live(debounce: 500)
                ->unique(PersonalInfo::class, 'identitynumber', ignoreRecord: true)                // ->rules([
                //     Rule::notIn(User::pluck('name')->toArray()) // Không cho phép trùng identitynumber với name của users
                // ])
                , // Kiểm tra hợp lệ trong Laravel validation
            ]),
                Grid::make(3)
                    ->schema([
                        TextInput::make('name')
                            ->label('Họ và Tên')
                            ->required()
                            ->maxLength(255),

                        Select::make('gender')
                            ->label('Giới tính')
                            ->options([
                                'Nam' => 'Nam',
                                'Nữ' => 'Nữ',
                            ])
                            ->default('Nam') // Mặc định chọn "Nam"
                            ->required(),

                        DatePicker::make('birth_date')
                            ->label('Ngày sinh')
                            ->required()
                            ->native(true) // Hiển thị popup chọn ngày thay vì input type="date"
                            ->format('Y-m-d') // Định dạng ngày tháng
                            ->displayFormat('d/m/Y') // Định dạng hiển thị
                            ->maxDate(now()) // Không cho chọn ngày trong tương lai
                            ->minDate(Carbon::now()->subYears(70))
                            ->default(Carbon::create(2000, 1, 1)) // Mặc định 01/01/2000
                            ->placeholder('Chọn ngày sinh') // Hiển thị placeholder khi chưa chọn
                        ,
                    ]),
                Grid::make(2)
                    ->schema([
                        TextInput::make('placeofbirth')
                        ->label('Nơi sinh')
                        ->maxLength(255),
                        TextInput::make('address')
                            ->label('Địa chỉ')
                            ->maxLength(255),


                ]),

                Grid::make(2)
                    ->schema([
                        TextInput::make('phone')
                            ->label('Số điện thoại')
                            ->tel()
                            ->maxLength(15),
                        TextInput::make('email')
                            ->label('Email')
                            ->email()
                            ->required()
                            ->unique('personal_infos', 'email') // Email không được trùng trong bảng personalinfos
                            // ->rules([
                            //     Rule::notIn(User::pluck('email')->toArray()) // Không cho phép trùng email với users
                            // ])
                            ->placeholder('Nhập email của bạn'),
                    ]),

            ]);
    }
////////////////////////////////////////////////////////////////////////////////////////
public static function createForm(Form $form): Form 
    {
        return $form->schema([

            Grid::make(1)
            ->schema([
            TextInput::make('identitynumber')
            ->label('CMND/CCCD')
            ->required()
            ->type('text') // Tránh hiển thị mũi tên tăng/giảm
            ->placeholder('Nhập 12 số CCCD')
            ->mask('999999999999') // Tạo mặt nạ nhập đúng 12 số
            ->extraInputAttributes([
                'inputmode' => 'numeric', // Hiển thị bàn phím số trên di động
                'pattern' => '\d{12}', // Chỉ cho phép nhập đúng 12 chữ số
                'oninput' => "this.value = this.value.replace(/[^0-9]/g, '')" // Chặn ký tự không phải số ngay khi nhập
            ])
            ->rule('regex:/^\d{12}$/')
            ->unique('personal_infos', 'identitynumber')
            // ->rules([
            //     Rule::notIn(User::pluck('name')->toArray()) // Không cho phép trùng identitynumber với name của users
            // ])
            , // Kiểm tra hợp lệ trong Laravel validation
        ]),
            Grid::make(3)
                ->schema([
                    TextInput::make('name')
                        ->label('Họ và Tên')
                        ->required()
                        ->maxLength(255),

                    Select::make('gender')
                        ->label('Giới tính')
                        ->options([
                            'Nam' => 'Nam',
                            'Nữ' => 'Nữ',
                        ])
                        ->default('Nam') // Mặc định chọn "Nam"
                        ->required(),

                    DatePicker::make('birth_date')
                        ->label('Ngày sinh')
                        ->required()
                        ->native(true) // Hiển thị popup chọn ngày thay vì input type="date"
                        ->format('Y-m-d') // Định dạng ngày tháng
                        ->displayFormat('d/m/Y') // Định dạng hiển thị
                        ->maxDate(now()) // Không cho chọn ngày trong tương lai
                        ->minDate(Carbon::now()->subYears(70))
                        ->default(Carbon::create(2000, 1, 1)) // Mặc định 01/01/2000
                        ->placeholder('Chọn ngày sinh') // Hiển thị placeholder khi chưa chọn
                    ,
                ]),
            Grid::make(2)
                ->schema([
                    TextInput::make('placeofbirth')
                    ->label('Nơi sinh')
                    ->maxLength(255),
                    TextInput::make('address')
                        ->label('Địa chỉ')
                        ->maxLength(255),


            ]),

            Grid::make(2)
                ->schema([
                    TextInput::make('phone')
                        ->label('Số điện thoại')
                        ->tel()
                        ->maxLength(15),
                    TextInput::make('email')
                        ->label('Email')
                        ->email()
                        ->required()
                        ->unique('personal_infos', 'email') // Email không được trùng trong bảng personalinfos
                        // ->rules([
                        //     Rule::notIn(User::pluck('email')->toArray()) // Không cho phép trùng email với users
                        // ])
                        ->placeholder('Nhập email của bạn'),
                ]),





        ]);
    }
////////////////////////////////////////////////////////////////////////////////////////
 public static function editForm(Forms\Form $form, $record): Forms\Form
    {
        return $form->schema([



        ]);
    }
////////////////////////////////////////////////////////////////////////////////////////

    public static function table(Table $table): Table
    {
        return $table
        ->columns([
            Tables\Columns\TextColumn::make('name')             ->label('Họ và Tên'),
            Tables\Columns\TextColumn::make('identitynumber')   ->label('CMND/CCCD'),
            Tables\Columns\TextColumn::make('phone')            ->label('Số điện thoại'),
            Tables\Columns\TextColumn::make('email')            ->label('Email')
        ->sortable()
        ->searchable()
            // Tables\Columns\TextColumn::make('gender')->label('Giới tính'),
        ])
        ->filters([])
        ->actions([
            Tables\Actions\EditAction::make(),
            Tables\Actions\DeleteAction::make(),
        ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListPersonalInfos::route('/'),
            'create' => Pages\CreatePersonalInfo::route('/create'),
            'edit' => Pages\EditPersonalInfo::route('/{record}/edit'),
        ];
    }
    public static function creating(PersonalInfo $record)
{
    if (!User::where('email', $record->email)->exists()) {
        User::create([
            'name' => $record->identitynumber,
            'email' => $record->email,
            'password' => bcrypt('12345678'),
        ]);
    }
}
public static function canCreate(): bool
{
    // Chỉ cần trả về false để tắt chức năng tạo mới và ẩn nút
    return false;
}
}
