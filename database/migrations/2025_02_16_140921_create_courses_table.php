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
        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->string('course_code')->unique(); // Mã khóa học duy nhất
            $table->foreignId('user_id')->constrained()->onDelete('cascade'); // ID học viên
            $table->foreignId('subject_id')->constrained()->onDelete('cascade'); // ID môn học
            $table->enum('status', ['errolled', 'in_process', 'cancelled','pausing','completed'])->default('errolled'); // Trạng thái khóa học
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('courses');
    }
};
