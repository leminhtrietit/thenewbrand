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
        Schema::create('course_fees', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_id')->constrained('courses')->onDelete('cascade'); // Liên kết với bảng courses
            $table->decimal('total_fee', 20, 0); // Tổng học phí của khóa học
            $table->decimal('discount', 20, 0)->default(0); // Số tiền giảm giá
            $table->string('gift')->nullable(); // quà tặng kèm
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('coursesfees');
    }
};
