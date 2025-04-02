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
        Schema::table('courses', function (Blueprint $table) {
            // Thêm các cột sau cột 'status' hiện có để dễ nhìn
            $table->date('enrollment_date')
                  ->after('status')
                  ->nullable() // Cho phép null hoặc đặt default tùy logic của bạn
                  ->comment('Ngày đăng ký khóa học');

            $table->decimal('base_fee', 15, 0) // 15 chữ số tổng, 2 chữ số sau dấu phẩy
                  ->after('enrollment_date')
                  ->default(0)
                  ->comment('Học phí gốc tại thời điểm đăng ký');

            $table->decimal('discount_amount', 15, 0)
                  ->after('base_fee')
                  ->default(0)
                  ->comment('Số tiền giảm giá áp dụng');

            $table->decimal('final_amount', 15, 0)
                  ->after('discount_amount')
                  ->default(0)
                  ->comment('Số tiền thực tế cần thu (base_fee - discount_amount)');

            $table->string('gift')
                  ->after('final_amount')
                  ->nullable() // Cho phép null nếu không có quà
                  ->comment('Mô tả quà tặng kèm (nếu có)');

            $table->string('payment_status')
                  ->after('gift')
                  ->default('unpaid') // Giá trị mặc định là chưa thanh toán
                  ->comment('Trạng thái thanh toán (vd: unpaid, paid, partially_paid)');

             // Bạn có thể thêm index cho các cột thường xuyên truy vấn
             // $table->index('enrollment_date');
             // $table->index('payment_status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('courses', function (Blueprint $table) {
            //
        });
    }
};
