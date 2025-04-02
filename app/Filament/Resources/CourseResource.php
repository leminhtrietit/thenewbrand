<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CourseResource\Pages;
use App\Filament\Resources\CourseResource\RelationManagers;
use App\Models\Course;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Models\User;
use App\Models\PersonalInfo;
use App\Models\Subject;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\ToggleColumn;

class CourseResource extends Resource
{
    protected static ?string $model = Course::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationLabel = 'Khóa Học';
    protected static ?string $pluralModelLabel = 'Khóa Học';
    protected static ?int $navigationSort = 3; // Ví dụ: đặt ở vị trí số 5

    public static function form(Form $form): Form
    {
        return $form
        ->schema([
        // TextInput::make('code')
        //     ->label('Mã khóa học')
        //     ->required(),
        Select::make('user_id')
            ->label('Học viên')
            ->options(
                PersonalInfo::get()->pluck('display_name', 'id')
            )            ->searchable()
            ->required(),
        Select::make('subject_id')
            ->label('Môn học')
            ->options(Subject::pluck('name', 'id'))
            ->searchable()
            ->required(),
        // TextInput::make('tuition_fee')
        //     ->label('Học phí (VND)')
        //     ->formatStateUsing(fn ($state) => number_format($state, 0, ',', '.'))
        //     ->extraInputAttributes([
        //         'oninput' => "this.value = this.value.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, '.');"            ])
        //     ->dehydrateStateUsing(fn ($state) => (float) str_replace('.', '', $state))
        //     ->required(),

        // TextInput::make('discount')
        //     ->label('Giảm giá')
        //     ->formatStateUsing(fn ($state) => number_format($state, 0, ',', '.'))
        //     ->extraInputAttributes([
        //         'oninput' => "this.value = this.value.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, '.');"            ])
        //     ->dehydrateStateUsing(fn ($state) => (float) str_replace('.', '', $state))
        //     ->required(),
        // TextInput::make('paid_amount')
        //     ->label('Đã thu')
        //     ->formatStateUsing(fn ($state) => number_format($state, 0, ',', '.'))
        //     ->extraInputAttributes([
        //         'oninput' => "this.value = this.value.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, '.');"            ])
        //     ->dehydrateStateUsing(fn ($state) => (float) str_replace('.', '', $state))
        //     ->required(),
        
        
        
        

        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('course_code')->label('Mã khóa học')->sortable()->searchable(),
                TextColumn::make('user.name')->label('Học viên')->sortable()->searchable(),
                TextColumn::make('subject.name')->label('Môn học')->sortable()->searchable(),
                ToggleColumn::make('status')->label('Hoàn thành'),
            ])
            ->filters([])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCourses::route('/'),
            'create' => Pages\CreateCourse::route('/create'),
            'edit' => Pages\EditCourse::route('/{record}/edit'),
        ];
    }
}
