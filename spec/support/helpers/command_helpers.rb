module CommandHelpers
    def output(command)
      command.results.map(&:messages).join("\n")
    end

    def exit_status(command)
      command.results.select(&:error?).map(&:status).first
    end
end