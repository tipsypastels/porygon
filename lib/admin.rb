module Admin
  APP = -> env do
    [200, { 'Content-Type' => 'text/plain' }, env]
  end

  def self.start
    Rack::Handler::Thin.run APP
  end
end