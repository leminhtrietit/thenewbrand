<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory; // Đúng namespace

class Department extends Model
{
    //
    use HasFactory;

    protected $fillable = ['name'];

    public function subjects()
    {
        return $this->hasMany(Subject::class);
    }
}
