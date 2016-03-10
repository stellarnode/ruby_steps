include Math


def decompose_actions(input)
    expression = []
    argument = ""
    string = input.split("")

    while string.length > 0 do
        op = string.shift

        case op

        when "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."
            argument += op

        when "*", "/", "**", "^", "+", "-"
            if argument == ""
                puts "Are you sure you have enough arguments in your expression?"
                exit(0)
            end

            argument = convert_to_numbers(argument)
            expression << argument

            if op == "*" && string[0] == "*"
                op += string.shift
            end
            
            expression << op
            argument = ""

        when ","
            puts "Please use dots (.) for decimals."
            exit(0)

        else
            puts "I don't understand some of the operators."
            puts "Please remember that I am a simple calculator."
            puts "Not a scientific one."
            exit(0)

        end

    end

    argument = convert_to_numbers(argument)
    expression << argument

    puts expression.to_s

    result = perform_first_priority_operations(expression)
    puts "after first priority ", result.to_s
    result = perform_second_priority_operations(result)
    puts "after second priority ", result.to_s

    puts "result ", result.to_s

    return result[0].to_s

end


def convert_to_numbers(string_to_convert)
    return (string_to_convert.include?(".")) ? string_to_convert.to_f : string_to_convert.to_i
end


def do_op(op, input)
    answer = 0
    idx1 = input.index(op) - 1
    idx2 = input.index(op) + 1

    case op

    when "**", "^"
        answer = input[idx1] ** input[idx2]
    
    when "*"
        answer = input[idx1] * input[idx2]

    when "/"
        answer = input[idx1] / input[idx2]

    when "+"
        answer = input[idx1] + input[idx2]

    when "-"
        answer = input[idx1] - input[idx2]

    end

    input.insert(idx2 + 1, answer)
    3.times { input.delete_at(idx1) }

    return input
end


def perform_first_priority_operations(input)

    if input.include?("**") || input.include?("^")

        while input.include?("**") || input.include?("^") do

            op = input.include?("**") ? "**" : "^"
            input = do_op(op, input)

        end

    end

    if input.include?("*") || input.include?("/")

        while input.include?("*") || input.include?("/") do

            op = input.include?("*") ? "*" : "/"
            input = do_op(op, input)     

        end

    end

    return input

end


def perform_second_priority_operations(input)

    if input.include?("+") || input.include?("-")

        while input.include?("+") || input.include?("-") do

            op = input.include?("+") ? "+" : "-"
            input = do_op(op, input) 

        end

    end

    return input
end


def calculate(input)

    input_cleaned = input.gsub(/\s/, "")
    arr = input_cleaned.split("")

    open_parans = []
    close_parans = []

    arr.each_with_index do |char, idx|
        open_parans << idx if char == "("
        close_parans << idx if char == ")"
    end

    if (open_parans.length == 0 && close_parans.length == 0)
        answer = decompose_actions(input_cleaned)
        return answer

    elsif (open_parans.length > 0 && close_parans.length == 0) || (open_parans.length == 0 && close_parans.length > 0)
        puts "It seems that the number of opening and closing"
        puts "parantheses does not match. Please check."
        exit(0)

    else
        in_parans = arr.slice(open_parans.min..close_parans.max)
        in_parans.shift
        in_parans.pop
        beginning = arr.slice(0...open_parans.min)
        ending = arr.slice((close_parans.max + 1)...arr.length)

        puts in_parans.to_s, beginning.to_s, ending.to_s

        beginning = beginning.length > 0 ? beginning.join("") : ""
        ending = ending.length > 0 ? ending.join("") : ""
        in_parans = in_parans.join("")

        answer = decompose_actions(beginning + calculate(in_parans) + ending)

        return answer
    end

    puts "answer ", answer

end



puts "Treat me as a simple calculator."
puts "And hit me with some numbers..."
puts "What do you want me to calculate?"

input = gets.chomp

calculate(input)