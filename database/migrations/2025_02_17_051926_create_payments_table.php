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
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_id')->constrained('courses')->onDelete('cascade'); // Liên kết với khóa học
            $table->decimal('payment_amount', 20, 0); // Số tiền thanh toán
            $table->dateTime('payment_date'); // Ngày thanh toán
            $table->string('payment_method')->nullable(); // Phương thức thanh toán (chuyển khoản, tiền mặt, ...)
            $table->text('note')->nullable(); // Ghi chú (nếu cần)
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
