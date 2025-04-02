<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    // Cho phép gán hàng loạt các trường này
    protected $fillable = [
        'course_id',
        'payment_amount',
        'payment_date',
        'payment_method',
        'note',
    ];

    /**
     * Quan hệ với model Course.
     * Mỗi khoản thanh toán thuộc về 1 khóa học.
     */
    public function course()
    {
        return $this->belongsTo(Course::class);
    }
}
