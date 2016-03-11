include Math


def decompose_actions(input)
    expression = []
    argument = ""
    string = input.split("")

    while string.length > 0 do
        op = string.shift

        # puts op
    
        case op

        when "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "%"
            argument += op

        when "*", "/", "**", "^", "+", "-"
            if argument == "" && op != "-"
                puts "Are you sure you have enough arguments in your expression?"
                exit(0)
            end

            if op == "*" && string[0] == "*"
                op += string.shift
            end
            
            if op == "-" && argument == "" && (expression.length == 0 || "+-**/^".include?(expression[expression.length - 1]))
                argument += op
                next
            end
            
            argument = convert_to_numbers(argument)
            expression << argument
            
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
    # puts "after first priority ", result.to_s
    result = perform_second_priority_operations(result)
    # puts "after second priority ", result.to_s

    # puts "result ", result.to_s

    return result[0].to_s

end


def convert_to_numbers(string_to_convert)
    if string_to_convert.end_with?("%")
       # puts "has percent"
       return string_to_convert
    end
    return (string_to_convert.include?(".")) ? string_to_convert.to_f : string_to_convert.to_i
end


def do_op(op, input)
    answer = 0
    idx1 = input.index(op) - 1
    idx2 = input.index(op) + 1
    
    if input[idx2].is_a?(String) && input[idx2].end_with?("%")
        input[idx2] = input[idx2][0..-2]
        input[idx2] = convert_to_numbers(input[idx2] + ".0") / 100 * input[idx1].abs
    end
    
    if input[idx1].is_a?(String) && input[idx1].include?("%")
        puts "I don't quite understand the % in the beginning."
        exit(0)
    end
    
    case op

    when "**", "^"
        answer = input[idx1] ** input[idx2]
    
    when "*"
        answer = input[idx1] * input[idx2]

    when "/"
        answer = input[idx1] / input[idx2].to_f

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
    inside_parans = input_cleaned.scan(/(\([^\(\)].+?\))/).flatten
    
    # puts inside_parans.to_s

    if (inside_parans.length == 0)
        answer = decompose_actions(input_cleaned)

    else
        inside_parans.each do |el|
            to_calc = el[1..-2]
            temp_answer = decompose_actions(to_calc)
            input_cleaned = input_cleaned.sub(el, temp_answer)
        end
        
        # puts "new cleaned input for next iteration: ", input_cleaned
        
        answer = calculate(input_cleaned)

    end

    if answer == answer.to_i
        answer = answer.to_i
    end
    
    # puts "answer ", answer
    return answer
end



puts "Treat me as a simple calculator and hit me with some numbers..."
puts "I think I can also understand parantheses and % signs."
puts "What do you want me to calculate?"
puts ""
print "> "

input = gets.chomp

puts ""
print "Answer: ", calculate(input)
puts ""
