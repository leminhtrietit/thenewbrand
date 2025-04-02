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
        Schema::create('enrollments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('personal_info_id')->constrained('personal_infos')->onDelete('cascade'); // Liên kết đến học viên
            $table->foreignId('course_id')->constrained('courses')->onDelete('cascade'); // Liên kết đến khóa học
            $table->date('enrollment_date');
            $table->decimal('base_fee', 15, 2)->default(0); // Học phí gốc lúc đăng ký
            $table->decimal('discount_amount', 15, 2)->default(0); // Tiền giảm giá
            $table->decimal('final_amount', 15, 2)->default(0); // Tiền cần thu
            $table->string('gift')->nullable(); // Quà tặng
            $table->string('status')->default('active'); // Trạng thái đăng ký
            $table->string('payment_status')->default('unpaid'); // Trạng thái thanh toán
            $table->timestamps(); // created_at, updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enrollments');
    }
};
