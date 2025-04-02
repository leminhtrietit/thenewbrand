<?php

namespace App\Filament\Resources\PersonalInfoResource\Pages;

use App\Filament\Resources\PersonalInfoResource;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use App\Models\User;
use Filament\Notifications\Notification;
use Illuminate\Database\Eloquent\Model;

class CreatePersonalInfo extends CreateRecord
{
    protected static string $resource = PersonalInfoResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $cccd = $data['identitynumber'] ?? null;

        if (PersonalInfoResource::isValidCCCD($cccd)) {
            // Tính toán và thêm gender, place_of_birth vào $data
            $data['gender'] = PersonalInfoResource::getGenderFromCCCD($cccd);
            $provinceCode = PersonalInfoResource::getProvinceCodeFromCCCD($cccd);
            $data['placeofbirth'] = PersonalInfoResource::getProvinceName($provinceCode);

            // Ngày sinh 'dob' đã có sẵn trong $data từ ô DatePicker (được set bởi afterStateUpdated)
        } else {
            // Đảm bảo giá trị là null nếu CCCD không hợp lệ
             $data['gender'] = null;
             $data['placeofbirth'] = null;
        }

        // Đảm bảo giá trị null cuối cùng nếu cần
        $data['gender'] = $data['gender'] ?? null;
        $data['placeofbirth'] = $data['placeofbirth'] ?? null;


        return $data; // Trả về dữ liệu đã được sửa đổi
    }

   
}