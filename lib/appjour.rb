require 'dnssd'
require 'set'
require 'pp'

Thread.abort_on_exception = true
module Appjour
  
  SERVICE = "_http._tcp"
  App   = Struct.new(:name, :host, :port)
  
  
  def self.list
    servers = {}
    service = DNSSD.browse(SERVICE) do |reply|
      servers[reply.name] ||= reply
    end
    STDERR.puts "Searching for servers (3 seconds)"
    # Wait for something to happen
    sleep 3
    service.stop
    servers.each { |string,obj| 
      name, port = string.split ":" 
      STDERR.puts "Found web app called '#{name}'"
    }
  end
  
  
  def self.find(name,first=nil)
    hosts = Set.new

    waiting = Thread.current
    
    STDERR.puts "searching for #{name}"

    service = DNSSD.browse(SERVICE) do |reply|
      if name === reply.name
        DNSSD.resolve(reply.name, reply.type, reply.domain) do |rr|
          hosts << App.new(reply.name, rr.target, rr.port)
          waiting.run if first
        end
      end
    end
    
    # wait to resolve multiple apps
    sleep 5
    service.stop

    hosts
  end
  
  def self.open(name)
    host = find(name,true).to_a[0]
    
    unless host
      STDERR.puts "unable to find #{name}"
    else
      system "open 'http://#{host.host}:#{host.port}'"
    end
  end
  
  # TODO
  # divine app port numbers 
  # mongrel: http://www.caboo.se/articles/2006/11/14/configure-mongrel-rails-logger-per-port
  def self.publish(name,port=:guess)
    STDERR.puts "Publishing #{name} on #{port}"
    
    if port.is_a?(Symbol)
      port = guess_port(port)
    else
      port = port.to_i
    end
    
    tr = DNSSD::TextRecord.new
    tr["description"] = "An app."
    
    DNSSD.register(name, SERVICE, "local", port.to_i, tr.encode) do |reply|
      STDERR.puts "Announcing #{name}..."
    end
    
    sleep
  end
  
  def self.guess_port(kind)
    case kind
    when :mongrel
    end
  end
end