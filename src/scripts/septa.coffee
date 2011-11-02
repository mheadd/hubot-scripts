# SEPTA Bus & Trolley schedule
#
# Uses the SEPTA SMS API - http://www3.septa.org/hackathon/
#
# septa me (StopID)
# septa me 17842
#
# septa me (StopID) (RouteID)
# septa me 17842 17
#
# septa me (StopID) (RouteID) (Direction)
# septa me 17842 17 o
#

module.exports = (robot) ->

  robot.respond /septa( me)?( \d{1,6})( \d{1,6})?( [a-z]{1})?/i, (msg) ->
    stopid = msg.match[2].replace /^\s+/g, ""
    routeid = if msg.match[3]? then msg.match[3].replace /^\s+/g, "" else ""
    direction = if msg.match[4]? then msg.match[4].replace /^\s+/g, "" else ""
    msg.http("http://www3.septa.org/sms/#{stopid}/#{routeid}/#{direction}")
      .get() (error, res, body) ->
         msg.send body


