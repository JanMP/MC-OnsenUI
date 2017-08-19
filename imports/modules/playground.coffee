#this isn't loaded by meteor
#this is just to run test scripts straight from atom

console.log 1 in [1, 2, 3]
_ = require "lodash"
math = require "mathjs"

{ Rnd } = require "../client/mathproblems/randomGenerators.coffee"
rnd = new Rnd()

nerdamer = require "./nerdamer/nerdamer.core.js"
require "./nerdamer/Solve.js"

coeffMatrix = (d) ->
  matrix = math.matrix (rnd.intsMin(-9,9)[1..d]for i in [1..d])
  unless (math.det matrix) is 0
    matrix
  else
    coeffMatrix d
dimension = 2
solutions = (rnd.intsMin -9, 9)[1..dimension]
solutionNames = rnd.uniqueLetters()[1..dimension]
coeffs = coeffMatrix dimension
rightSides = math.multiply(coeffs, solutions)
equations = (
  for rightSide, i in rightSides._data
    leftSide = ""
    for solutionName, j in solutionNames
      coeff = coeffs._data[i][j]
      leftSide += " + #{coeff}*#{solutionName}"
    refinedLeftSide = nerdamer(leftSide).text "fractions"
    "#{refinedLeftSide} = #{rightSide}"
)
console.log equations
#console.log nerdamer("f(x)=3x").text "fractions"
# { submissions } = require "./data.coffee"
#
# query =
#   _(submissions)
#   .countBy "userId"
#   .value()
#
# console.log query
#
# query1 =
#   _(submissions)
#   .countBy (e) -> "#{e.userId} #{e.problem}"
#   .value()
#
# query2 = (problem) ->
#   _(submissions)
#   .filter (e) -> e.problem is problem
#   .map (e) -> e.date
#   .value()
#
# console.log (for key, value of query1 when 10 < value
#   [userId, problem] = key.split " "
#   {userId, problem}
# )
