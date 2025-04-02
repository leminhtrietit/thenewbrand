<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory; // Đúng namespace

class Subject extends Model
{
    //
    use HasFactory;

    protected $fillable = ['name', 'department_id', 'price'];

    public function department()
    {
        return $this->belongsTo(Department::class);
    }
    public function getFormattedPriceAttribute()
    {
        return number_format($this->price, 0, ',', '.');
    }
}
