<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resource extends Model
{
    use HasFactory;

    protected $table = 'resources';

    protected $fillable = [
        'appname',
        'version',
        'link_truycap',
        'ten_hanhdong',
        'trangthai_link',
    ];
}
