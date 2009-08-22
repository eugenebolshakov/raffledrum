factories = Dir.glob(File.dirname(__FILE__) + '/factories/*.rb').sort
factories.uniq.each { |path| require path }
