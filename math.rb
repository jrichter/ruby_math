# This is a simple math problem generator and interactive "timed game"
#
# Have Fun!

class MathGenerator

  def initialize(num_high,math_type)
    @num_high = num_high
    @math_type = math_type # Addition or Subtraction
  end

  def generate_number(num_high = @num_high)
    rand(num_high)
  end

  def generate_problem
    first = generate_number
    second = generate_number
    unless first > second
      first, second = second, first # I only want positve numbers
    end
    problem = "#{first} #{@math_type} #{second}"
    if @math_type == "+"
      answer = first + second
    else
      answer = first - second
    end
    pp = pp_problem(first,second)
    return [pp, problem, answer]
  end

  def pp_problem(first,second)
    line_0 = "\n\n****\n"
    line_1 = insert_spaces(first) + first.to_s + "\n"
    line_2 = " #{@math_type}\n"
    line_3 = insert_spaces(second) + second.to_s + "\n"
    line_4 = "_____\n"
    return line_0 + line_1 + line_2 + line_3 + line_4
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
      spaces = spaces + " "
    end
    return spaces
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

  def get_math_type
    print "Do you want to do addition or subtraction?\n"
    print "1 - Addition\n"
    print "2 - Subtraction\n"
    mt = gets.chomp
    if mt.to_i == 1
      print "Addition it is!\n"
      mt = '+'
    elsif mt.to_i == 2
      print "Subtraction fun!\n"
      mt = '-'
    else
      print "You have entered an incorrect option."
      get_math_type
    end
    @math_type = mt
  end

  def get_max_num
    print "What is the highest number you want to add or subtract from?\n"
    num = gets.chomp.to_i
    unless num.integer?
      print "Please enter a number."
      get_max_num
    end
    @num_high = num
  end

  def display_and_get_problem(prob)
    print prob[0]
    num = gets.chomp.to_i
    unless num.integer?
      print "please enter a number as your answer"
      display_and_get_problem(prob)
    end
    return num
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
    if res > 0
      print "Don't worry, you will get better!\n"
    end
    print "Thanks for playing! You rock!\n"
  end

  def play_again?
    print "Do you want to play again? (y/n)  "
    res = gets.chomp
    if res == "y"
      @correct = 0
      @incorrect = [0]
      play
    else
      print "See you later!\n"
    end
  end

  def play
    # Setup Game
    get_math_type
    get_max_num
    start_timer
    # Setup generator
    gen = MathGenerator.new(@num_high,@math_type)
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
