require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できる場合' do
      it "'全ての項目の入力がが存在すれば登録できること'" do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上かつ半角英数字混合であれば登録できること' do
        @user.password = '12345a'
        @user.password_confirmation = '12345a'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空の場合、エラーになること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空の場合、エラーになること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが重複している場合、エラーになること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailが@を含まない場合、エラーになること' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空の場合、エラーになること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが6文字未満の場合、エラーになること' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角数字のみのときに登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は有効ではありません。')
      end

      it 'passwordが半角英語のみのときに登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は有効ではありません。')
      end

      it 'passwordが全角のときに登録できないこと' do
        @user.password = '１２３４５A'
        @user.password_confirmation = '１２３４５A'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は有効ではありません。')
      end

      it 'password_confirmationがpasswordと異なる場合、エラーになること' do
        @user.password_confirmation = 'password_differs'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)の名字が空の場合、エラーになること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'お名前(全角)の名前が空の場合、エラーになること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'お名前(全角)の名字に半角が入っている場合、エラーになること' do
        @user.last_name = 'Yamadaﾀﾛｳ123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角(漢字・ひらがな・カタカナ)で入力して下さい。')
      end

      it 'お名前(全角)の名字に半角が入っている場合、エラーになること' do
        @user.first_name = 'Yamadaﾀﾛｳ123'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角(漢字・ひらがな・カタカナ)で入力して下さい。')
        expect(@user.save).to be_falsey
      end

      it 'お名前カナ(全角)名字のフリガナが空の場合、エラーになること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'お名前カナ(全角)名前のフリガナが空の場合、エラーになること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'お名前カナ(全角)が全角（カタカナ）での入力されていないとエラーになること' do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力して下さい。')
      end

      it '名字カナ(全角)が全角（カタカナ）での入力されていないとエラーになること' do
        @user.last_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力して下さい。')
      end

      it '生年月日が空だと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
