<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    //
    use HasFactory;

    protected $fillable = [
        'course_code',
        'user_id',
        'subject_id',
        'status',
        'enrollment_date',
        'base_fee',
        'discount_amount',
        'final_amount',
        'gift',
        'payment_status',

    ];

    // Quan hệ với User (Học viên)
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Quan hệ với Subject (Môn học)
    public function subject()
    {
        return $this->belongsTo(Subject::class);
    }
    protected $casts = [
        'status' => 'boolean',
    ];
    public function personalInfo()
    {
        return $this->belongsTo(PersonalInfo::class);
    }
    /**
     * Quan hệ 1-1 với CourseFee.
     */
    public function courseFee()
    {
        return $this->hasOne(CourseFee::class);
    }

    /**
     * Quan hệ 1-n với Payment.
     */
    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    /**
     * Tính tổng số tiền đã thanh toán.
     */
    public function getTotalPaidAttribute()
    {
        return $this->payments()->sum('payment_amount');
    }

    /**
     * Tính số tiền còn thiếu sau khi áp dụng giảm giá.
     */
    public function getBalanceAttribute()
    {
        return $this->courseFee ? $this->courseFee->final_amount - $this->total_paid : 0;
    }
}
