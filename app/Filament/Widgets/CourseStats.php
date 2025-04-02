<?php

namespace App\Filament\Widgets;

// Bỏ dòng use App\Filament\Widgets\CourseStats; vì không cần thiết trong chính file này
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat; // Mặc dù bạn dùng Card, để đây cũng không sao
use Filament\Widgets\StatsOverviewWidget\Card; // Đảm bảo đã use Card
use App\Models\Course;
use Carbon\Carbon;

class CourseStats extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            // Tạo Card để hiển thị số khóa học tạo trong ngày
            Card::make('Course', Course::whereDate('created_at', Carbon::today())->count())
                ->description('Today Course Registered ')
                ->color('success'), // Bỏ dấu phẩy ở cuối nếu đây là Card duy nhất

            // Bạn có thể thêm các Card khác ở đây, cách nhau bằng dấu phẩy
            // Ví dụ:
            Card::make('Tổng số khóa học', Course::count())
                ->description('Tổng số khóa học hiện có')
                ->color('primary'),
        ];
    }
}