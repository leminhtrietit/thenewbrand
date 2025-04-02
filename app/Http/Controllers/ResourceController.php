<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Resource;

class ResourceController extends Controller
{
    // public function index()
    // {
    //     $resources = Resource::all();

    //     return view('resource', compact('resources'));
    // }
    public function index(Request $request)
    {
        // Lấy giá trị tìm kiếm từ query string (nếu có)
        $search = $request->input('search');

        // Khởi tạo query
        $query = Resource::query();

        // Nếu có từ khóa tìm kiếm, lọc theo cột appname (có thể mở rộng cho các cột khác nếu cần)
        if ($search) {
            $query->where('appname', 'like', '%' . $search . '%');
        }

        // Sắp xếp theo appname theo thứ tự tăng dần (A -> Z)
        $resources = $query->orderBy('appname', 'asc')->get();

        // Trả về view kèm dữ liệu tìm kiếm và kết quả
        return view('resource', compact('resources', 'search'));
    }
}
