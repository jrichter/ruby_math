# File:  tc_math.rb

require_relative '../math.rb'
require 'test/unit'

# Testing for math.rb
class TestMath < Test::Unit::TestCase
  def setup
    @num_high = 10
    @gen = MathGenerator.new(@num_high, '+').generate_numbers
    @add = MathGenerator.new(@num_high, '+')
    @sub = MathGenerator.new(@num_high, '-')
    @mul = MathGenerator.new(@num_high, '*')
    @div = MathGenerator.new(@num_high, '/')
  end

  def test_generate_numbers
    # It returns an array
    assert_kind_of(Array, @gen)
    # The array is filled with numbers
    assert_kind_of(Integer, @gen[0])
    assert_kind_of(Integer, @gen[1])
    # The first number is greater than or equal to the second
    assert(@gen[0] >= @gen[1],
           "The first number: #{@gen[0]}"\
           "is not greater than the second: #{@gen[1]}.")
  end

  def test_pp_problem
    assert_match(/\n+\** +\d+\n \+|-|\*\n +\d+\n_+\n/, @add.pp_problem(@gen[0], @gen[1]))
    assert_match(/\n+\** +\d+\n \+|-|\*\n +\d+\n_+\n/, @sub.pp_problem(@gen[0], @gen[1]))
    assert_match(/\n+\** +\d+\n \+|-|\*\n +\d+\n_+\n/, @mul.pp_problem(@gen[0], @gen[1]))
  end

  def test_pp_div_problem
    assert_match(/\n+\**\n +_+\n \d+ \| \d+ \n_+\n/, @div.pp_div_problem(@gen[0], @gen[1]))
  end

  def test_generate_addition_problem
    # It returns an array
    assert_kind_of(Array, @add.generate_addition_problem)
    # The array has two strings and a number
    assert_kind_of(String, @add.generate_addition_problem[0])
    assert_kind_of(String, @add.generate_addition_problem[1])
    assert_kind_of(Integer, @add.generate_addition_problem[2])
  end

  def test_generate_subtraction_problem
    # It returns an array
    assert_kind_of(Array, @sub.generate_subtraction_problem)
    # The array has two strings and a number
    assert_kind_of(String, @sub.generate_subtraction_problem[0])
    assert_kind_of(String, @sub.generate_subtraction_problem[1])
    assert_kind_of(Integer, @sub.generate_subtraction_problem[2])
  end

  def test_generate_multiplication_problem
    # It returns an array
    assert_kind_of(Array, @mul.generate_multiplication_problem)
    # The array has two strings and a number
    assert_kind_of(String, @mul.generate_multiplication_problem[0])
    assert_kind_of(String, @mul.generate_multiplication_problem[1])
    assert_kind_of(Integer, @mul.generate_multiplication_problem[2])
  end

  def test_generate_division_problem
    # It returns an array
    assert_kind_of(Array, @div.generate_division_problem)
    # The array has two strings
    assert_kind_of(String, @div.generate_division_problem[0])
    assert_kind_of(String, @div.generate_division_problem[1])
    # The last is a string or an integer
    assert(@div.generate_division_problem[2].class == String || Integer)
  end
end
