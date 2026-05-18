function cc --wraps='cd ~/claude-code && claude' --description 'alias cc cd ~/claude-code && claude'
    cd ~/claude-code && claude --dangerously-skip-permissions $argv
end
