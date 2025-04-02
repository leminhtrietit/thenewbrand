<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Subject;
use App\Models\Department;

class SubjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
         //
         $subjects = [
            ['name' => 'Toán cao cấp', 'department_id' => 1, 'price' => 1500000],
            ['name' => 'Vật lý đại cương', 'department_id' => 1, 'price' => 1400000],
            ['name' => 'Nguyên lý kế toán', 'department_id' => 2, 'price' => 1300000],
            ['name' => 'Đồ họa Photoshop', 'department_id' => 3, 'price' => 2000000],
            ['name' => 'Vẽ kỹ thuật cơ bản', 'department_id' => 4, 'price' => 1800000],
            ['name' => 'Lập trình PHP', 'department_id' => 5, 'price' => 2500000],
        ];

        foreach ($subjects as $subject) {
            Subject::create($subject);
        }
    }
}
