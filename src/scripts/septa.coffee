# Allows Hubot to query the SEPTA bus & trolley schedule
# 
# septa me <stopid> - Returns the next 4 scheduled bus/trolleys at specified station.
# septa me <stopid> <routeid> - Returns only bus/trolleys at station for specified route.
# septa me <stopid> <routeid> <direction> - Returns only inbound/outbound routes
#
# septa me 17482 17 o - Returns
# 			 Chew Av & Washington Ln
#			  Rt. 18 @ 3:49p 
#			  Rt. 18 @ 3:49p 
#			  Rt. 18 @ 3:59p 
#			  Rt. 18 @ 4:06p 

module.exports = (robot) ->

  robot.respond /septa( me)?( \d{1,6})( \d{1,6})?( [a-z]{1})?/i, (msg) ->
    stopid = msg.match[2].replace /^\s+/g, ""
    routeid = if msg.match[3]? then msg.match[3].replace /^\s+/g, "" else ""
    direction = if msg.match[4]? then msg.match[4].replace /^\s+/g, "" else ""
    msg.http("http://www3.septa.org/sms/#{stopid}/#{routeid}/#{direction}")
      .get() (error, res, body) ->
         msg.send body


