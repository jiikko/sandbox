mock = Minitest::Mock.new.expect(:call, true, [])
class Hoge
  def run
    internal
  end

  def internal
    'hello'
  end
end

hoge = Hoge.new
hoge.stub :internal, 'hello from mock' do 
  cat.internal
end
mock.verify
