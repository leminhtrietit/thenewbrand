<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

Route::get('/', function () {
    return view('welcome');
})->name('home');

Route::get('/resource', [App\Http\Controllers\ResourceController::class, 'index'])->name('resource.index');
Route::get('/download', [App\Http\Controllers\ResourceController::class, 'index']);
Route::get('/learning/aiforwork/buoi2', function () {
    return view('buoi2'); // Đảm bảo có file resources/views/buoi2.blade.php
});

Route::get('/clear-cache', function () {
    Artisan::call('cache:clear');
    Artisan::call('view:clear');
    Artisan::call('config:clear');
    Artisan::call('route:clear');
    return "Đã xóa cache!";
});