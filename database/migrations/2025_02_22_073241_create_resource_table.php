<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('resource', function (Blueprint $table) {
            $table->id();
            $table->string('appname');            // Tên ứng dụng
            $table->string('version')->nullable(); // Phiên bản
            $table->string('link_truycap');       // Link truy cập
            $table->string('ten_hanhdong');       // Tên hành động
            $table->boolean('trangthai_link')->default(true); // Trạng thái link (true/false)
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource');
    }
};
