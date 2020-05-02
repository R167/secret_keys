# frozen_string_literal: true

require 'secret_keys'
require 'optparse'

class SecretKeys
  # Command line interface for {SecretKeys}
  # @private
  class CLI
    def initialize(argv)
      @argv = argv.dup
      @action = @argv.shift
      @should_exit = true
      @encryption_key = nil

      if @action == 'encrypt'
        parse_encrypt!
      elsif @action == 'decrypt'
        parse_decrypt!
      elsif @action == '--all-help'
        @should_exit = false
        @argv = ['--help']
        parse_encrypt!
        puts
        @argv = ['--help']
        parse_decrypt!
        exit
      else
        STDERR.puts <<~HELP
        ERR: You must call with one of <encrypt|decrypt>
        Usage: secret_keys <encrypt|decrypt> [options...]
          Call with `--all-help` for all help docs.
        HELP
        exit 1
      end
    end

    def run!
      if @action == 'encrypt'

      elsif @action == 'decrypt'

      else
        STDERR.puts "ERR: Cannot run invalid action '#{@action}'!"
        exit 1
      end
    end

    def parse_decrypt!
      OptionParser.new do |opts|
        opts.banner = 'Usage: secret_keys decrypt [options] <input_file>'

        add_common_opts!(opts)
      end.parse!(@argv)
    end

    def parse_encrypt!
      OptionParser.new do |opts|
        opts.banner = 'Usage: secret_keys encrypt [options] <input_file> [output_file]'

        add_common_opts!(opts)

      end.order!(@argv)
    end

    def add_common_opts!(opts)
      opts.on('--secret ENCRYPTION_KEY', String, "Encryption key used to encrypt strings in the JSON file. This value can also be passed in the SECRET_KEYS_ENCRYPTION_KEY environment variable or via STDIN.") do |value|
        encryption_key = value
      end

      opts.on_tail("--help", "Prints this help") do
        puts opts.help
        exit if @should_exit
      end
    end

    def decrypt
      @secret_keys
    end
  end
end
