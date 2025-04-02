<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Filament\Resources\UserResource\RelationManagers;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Pages\ListRecords;
use Filament\Resources\Pages\CreateRecord;
use Filament\Resources\Pages\EditRecord;
use Filament\Tables\Columns\TextColumn;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Spatie\Permission\Models\Role;
use Filament\Tables\Actions\Action;
use Hash;
use Filament\Forms\Components\FileUpload;

class UserResource extends Resource
{
    protected static ?string $model = User::class;
    protected static ?string $navigationLabel = 'Quản lí tài khoản';
    protected static ?string $pluralLabel = 'Quản lí tài khoản';
    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    // Thêm dòng này để nhóm Resource lại
    protected static ?string $navigationGroup = 'Account'; // Tên nhóm bạn muốn

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
        ->columns([
            TextColumn::make('name')->label('ID')->sortable()->searchable(),
            // TextColumn::make('email')->label('Email')->sortable()->searchable(),
            // TextColumn::make('identitynumber')->label('Passport'),
            TextColumn::make('email')->label('Email'),
            // TextColumn::make('roles.name')->label('Vai Trò')->sortable(),
            // TextColumn::make('created_at')->label('Ngày tạo')->dateTime(),
        ])
        ->filters([])
        ->actions([
            Tables\Actions\EditAction::make(),
            // Tables\Actions\DeleteAction::make(),
            Action::make('resetPassword')
                ->label('Đặt lại mật khẩu')
                ->action(function (User $record) {
                    // Đặt mật khẩu mới bằng identitynumber đã mã hóa
                    $newPassword = bcrypt($record->identitynumber);
                    // Cập nhật mật khẩu mới cho người dùng
                    $record->update(['password' => $newPassword]);
                    // Hiển thị thông báo thành công
                    \Filament\Notifications\Notification::make()
                        ->title('Khôi phục mật khẩu thành công!')
                        ->success()
                        ->send();
                })
                ->requiresConfirmation()
                ->icon('heroicon-o-key'),
        ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }
    public static function canCreate(): bool
{
    return false; // Không cho phép tạo user
}

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}
