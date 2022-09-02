require './spec/rails_helper.rb'
require './domains/command_service/user_command_service.rb'
require './domains/domain_object/user_domain.rb'
require './domains/aggregate/user_aggregate.rb'
require './infras/write_repository/user_write_repository.rb'
require './infras/read_repository/user_read_repository.rb'
ud = UserDomain.new
ua = UserAggregate.new
uwr = UserWriteRepository.new
urr = UserReadRepoistory.new
ucs = UserCommandService.new(ud,ua,uwr,urr)
user = ucs.new(name: 'chaki',password: '12345',avatar: './app/assets/images/hayasi.jpg', adult_flg: nil)


describe  UserAggregate do
    context 'ユーザーの名前に文字列が入ると'
    it 'インスタンス作成される' do
        expect(ua.name('chaki').value).to eq 'chaki'
    end
end


describe UserAggregate do
    context 'ユーザーの名前に数字が入ると'
    it 'errが返される' do
        _, err = ua.name(1)
        expect(err).not_to be nil
    end
end

describe 'ユーザーの名前が空だと' do
    it 'errが返される' do
        _, err = ua.name(nil)
        expect(err).not_to be nil
    end
end

describe 'パスワードが5文字以上12文字以下だと' do
    it '登録できる' do

        expect(ua.password('123456').value).to eq  '123456'
    end
end

describe 'パスワードが5文字以下だと' do
    it 'errが返される' do
        _, err = ua.password('1234')
        expect(err).not_to be nil
    end
end

describe 'パスワードが12文字以上だと' do
    it 'errが返される' do
        _, err = ua.password('1234567891234')
        expect(err).not_to be nil
    end
end

