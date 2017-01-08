local a=require"luci.sys"
local e=luci.model.uci.cursor()
local e=require"nixio.fs"
require("luci.sys")
local t,e,o

t=Map("aliddns",translate("AliDDNS"))

e=t:section(TypedSection,"base",translate("Base"))
e.anonymous=true

enable=e:option(Flag,"enable",translate("enable"),translate("Enable / Disable AliDDNS"))
enable.rmempty=false

token=e:option(Value,"app_key",translate("Access Key ID"))
email=e:option(Value,"app_secret",translate("Access Key Secret"))

iface=e:option(ListValue,"interface",translate("WAN Interface"),translate("Select the Interface for AliDDNS, like wan/pppoe-wan"))
iface:value("",translate("Select WAN Interface"))
for t,e in ipairs(a.net.devices())do
	if e~="lo"then iface:value(e)end
end

iface.rmempty=false
main=e:option(Value,"main_domain",translate("Main Domain"),translate("The Main Domain, like: github.com"))
main.rmempty=false
sub=e:option(Value,"sub_domain",translate("Sub Domain"),translate("The Sub Domain, example: test.github.com -> test"))
sub.rmempty=false
time=e:option(Value,"time",translate("Inspection Time"),translate("Unit: Minute, Range: 1-59"))
time.rmempty=false

e=t:section(TypedSection,"base",translate("Update Log"))
e.anonymous=true
local a="/var/log/aliddns.log"
tvlog=e:option(TextValue,"sylogtext")
tvlog.rows=16
tvlog.readonly="readonly"
tvlog.wrap="off"

function tvlog.cfgvalue(e,e)
	sylogtext=""
	if a and nixio.fs.access(a)then
		sylogtext=luci.sys.exec("tail -n 100 %s"%a)
	end
	return sylogtext
end

tvlog.write=function(e,e,e)
end
local e=luci.http.formvalue("cbi.apply")
if e then
	io.popen("/etc/init.d/aliddns restart")
end
return t
