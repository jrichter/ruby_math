# coding: utf-8
# This is a simple math problem generator and interactive "timed game"
#
# Have Fun!

class MathGenerator

  def initialize(num_high, math_type)
    @num_high = num_high
    @math_type = math_type # Addition or Subtraction
  end

  def generate_numbers(num_high = @num_high)
    if @math_type == '/'
      first = rand(1..num_high)
      second = rand(1..9)
    else
      first = rand(num_high)
      second = rand(num_high)
    end
    unless first > second
      first, second = second, first # I only want the answer to be positive
    end
    return first, second
  end

  def pp_problem(first, second)
    line_0 = "\n\n****\n"
    line_1 = insert_spaces(first) + first.to_s + "\n"
    line_2 = " #{@math_type}\n"
    line_3 = insert_spaces(second) + second.to_s + "\n"
    line_4 = "_____\n"
    line_0 + line_1 + line_2 + line_3 + line_4
  end

  def pp_div_problem(first, second)
    line_0 = "\n\n****\n"
    line_1 = "    ____\n"
    line_2 = " #{second.to_s} | #{first.to_s} \n"
    line_3 = "_____\n"
    line_0 + line_1 + line_2 + line_3
  end

  def generate_addition_problem
    first, second = generate_numbers
    problem = "#{first} #{@math_type} #{second}"
    pp = pp_problem(first, second)
    answer = first + second
    return [pp, problem, answer]
  end

  def generate_subtraction_problem
    first, second = generate_numbers
    problem = "#{first} #{@math_type} #{second}"
    pp = pp_problem(first, second)
    answer = first - second
    return [pp, problem, answer]
  end

  def generate_multiplication_problem
    first, second = generate_numbers
    problem = "#{first} #{@math_type} #{second}"
    pp = pp_problem(first, second)
    answer = first * second
    return [pp, problem, answer]
  end

  def generate_division_problem
    first, second = generate_numbers
    # Can't divide by 0!
    answer = first / second
    remainder = first % second
    answer = "#{answer.to_s}R#{remainder.to_s}" if remainder != 0
    problem = "#{first} ÷ #{second}"
    pp = pp_div_problem(first, second)
    return [pp, problem, answer]
  end

  def generate_problem
    case @math_type
    when '+'
      generate_addition_problem
    when '-'
      generate_subtraction_problem
    when '*'
      generate_multiplication_problem
    when '/'
      generate_division_problem
    end
  end

  def insert_spaces(number)
    number = number.to_s
    if number.length > 4
      num = 0
    else
      num = 4 - number.length
    end
    spaces = ''
    num.times do
      spaces += ' '
    end
    spaces
  end
end

class MathProgram

  def initialize
    print "Welcome.  You have come to test your math skills, yes?\n"
    @num_high = 0
    @math_type = ''
    @correct = 0
    @incorrect = [0]
    @time = Time.now
  end

  def select_math_type
    print "Pick yer learnin' matey!\n"
    print "1 - Addition\n"
    print "2 - Subtraction\n"
    print "3 - Multiplication\n"
    print "4 - Division\n"
    mt = gets.chomp
    case mt
    when '1'
      print "Addition it is!\n"
      mt = '+'
    when '2'
      print "Subtraction fun!\n"
      mt = '-'
    when '3'
      print "Multiplication it is!\n"
      mt = '*'
    when '4'
      print "Division it is!\n"
      mt = '/'
    else
      print 'You have entered an incorrect option.'
      select_math_type
    end
    @math_type = mt
  end

  def select_max_num
    print "What is the highest number you want to play with?\n"
    num = gets.chomp
    unless num =~ /\d+/
      print "Oops! That wasn't a number!\n"
      select_max_num
    else
      @num_high = num.to_i
    end
  end

  def display_and_get_problem(prob)
    # Display the text of the problem
    print prob[0]
    # Get the user input
    # Check for division and do special stuff
    if @math_type == '/'
      num = gets.chomp
      unless num =~ /\dR\d/
        num = num.to_i
      end
    else
      # Must not be division
      num = gets.chomp
      unless num =~ /\d+/
        print 'please enter a number as your answer'
        display_and_get_problem(prob)
      else
        num = num.to_i
      end
    end
  end

  def start_timer
    @time = Time.now
  end

  def display_results
    print "Congratulations! You got #{@correct} correct!\n"
    res = @incorrect[0]
    @incorrect.reverse!.pop
    @incorrect.each do |results|
      print "You missed, #{results[0]}.\n"
      print "You answered, #{results[2]}.\n"
      print "The correct answer is, #{results[1]}.\n"
    end
    print "Don't worry, you will get better!\n" if res > 0
    print "Thanks for playing! You rock!\n"
  end

  def play_again?
    print 'Do you want to play again? (y/n)  '
    res = gets.chomp
    if res == 'y'
      @correct = 0
      @incorrect = [0]
      play
    else
      print "See you later!\n"
    end
  end

  def play
    # Setup Game
    select_math_type
    select_max_num
    start_timer
    # Setup generator
    gen = MathGenerator.new(@num_high, @math_type)
    # Start event Loop
    loop do
      prob = gen.generate_problem
      answer = display_and_get_problem(prob)
      if answer == prob[2]
        @correct += 1
      else
        @incorrect[0] += 1
        @incorrect << [prob[1], prob[2], answer]
      end
      if Time.now > @time + 60
        print "1 minute has expired!\n"
        print "How did you do?\n"
        sleep 2
        break
      end
    end
    display_results
    play_again?
  end
end
