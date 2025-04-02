<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PersonalInfo extends Model
{
    use HasFactory;

    protected $fillable = [
        'identitynumber',
        'name',
        'dateofbirth',
        'email',
        'phone',
        'address',
        'placeofbirth',
        'gender',
        'user_id',

    ];

    public function courses()
    {
        return $this->hasMany(Course::class, 'personal_info_id');
    }
    // protected static function booted()
    // {
    //     static::created(function ($personalInfo) {
    //         // Tạo user mới khi PersonalInfo được tạo
    //         \App\Models\User::create([
    //             'name' => $personalInfo->id,   // Gán 'identitynumber' cho trường 'name' của user
    //             'email' => $personalInfo->email,           // Gán 'email' của học viên cho user
    //             'password' => bcrypt('123456'),   // Mật khẩu mặc định cho người dùng
    //         ]);
    //     });

    //     static::updated(function ($personalInfo) {
    //         // Cập nhật thông tin người dùng khi PersonalInfo được cập nhật
    //         $user = \App\Models\User::where('id', $personalInfo->id)->first();

    //         if ($user) {
    //             $user->update([
    //                 'email' => $personalInfo->email,           // Cập nhật 'email'
    //                 'password' => bcrypt('123456'),            // Mật khẩu mặc định cho người dùng
    //             ]);
    //         }
    //     });
    // }
    public function getDisplayNameAttribute()
    {
        return "{$this->name} - {$this->identitynumber} - {$this->phone}";
    }
}
