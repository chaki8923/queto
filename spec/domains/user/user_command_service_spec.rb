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
