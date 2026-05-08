--!nolint
--!nocheck
--!optimize 2
--!native

--[[
    @link https://github.com/biggaboy212/TopbarPlusPlus
    @author biggaboy212
    @repository TopbarPlusPlus
    @license MIT*

    ---
    Copyright © 2026 biggaboy212

    *Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

    ---

    This file was automatically @generated with ProCMP, it is not intended for manual editing.
--]]

if not game:IsLoaded() then
	game.Loaded:Wait()
end

type ExpectedObject__DARKLUA_TYPE_a=((...any)->...any)|Instance|ServiceProvider
type Connection__DARKLUA_TYPE_b<Variant...=...any> ={Disconnect:(self:
Connection__DARKLUA_TYPE_b<Variant...>)->()}type Signal__DARKLUA_TYPE_c<Variant
...=...any> ={Connect:(self:Signal__DARKLUA_TYPE_c<Variant...>,func:(Variant...
)->())->Connection__DARKLUA_TYPE_b<Variant...>,Once:(self:Signal__DARKLUA_TYPE_c
<Variant...>,func:(Variant...)->())->Connection__DARKLUA_TYPE_b<Variant...>,Wait
:(self:Signal__DARKLUA_TYPE_c<Variant...>)->Variant...}type
IconState__DARKLUA_TYPE_d='Deselected'|'Selected'|'Viewing'type
Events__DARKLUA_TYPE_e='selected'|'deselected'|'toggled'|'viewingStarted'|
'viewingEnded'|'notified'type Alignment__DARKLUA_TYPE_f='Left'|'Center'|'Right'
type EventSource__DARKLUA_TYPE_g='User'|'OneClick'|'AutoDeselect'|
'HideParentFeature'|'Overflow'type Modification__DARKLUA_TYPE_h={any}type
StaticFunctions__DARKLUA_TYPE_i={getIcons:typeof(function():{
Icon__DARKLUA_TYPE_l}return(nil::any)::{Icon__DARKLUA_TYPE_l}end),getIcon:
typeof(function(a:string):Icon__DARKLUA_TYPE_l?return nil::any end),
setTopbarEnabled:typeof(function(a:boolean)end),modifyBaseTheme:typeof(function(
a:{Modification__DARKLUA_TYPE_h})end),setDisplayOrder:typeof(function(a:number)
end)}type Methods__DARKLUA_TYPE_j={setName:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:string):Icon__DARKLUA_TYPE_l return nil::any end),
getInstance:typeof(function(a:Icon__DARKLUA_TYPE_l,b:string):Instance?return(nil
::any)::Instance?end),modifyTheme:typeof(function(a:Icon__DARKLUA_TYPE_l,b:{
Modification__DARKLUA_TYPE_h}|Modification__DARKLUA_TYPE_h):Icon__DARKLUA_TYPE_l
return nil::any end),modifyChildTheme:typeof(function(a:Icon__DARKLUA_TYPE_l,b:{
Modification__DARKLUA_TYPE_h}):Icon__DARKLUA_TYPE_l return nil::any end),
setEnabled:typeof(function(a:Icon__DARKLUA_TYPE_l,b:boolean):
Icon__DARKLUA_TYPE_l return nil::any end),select:typeof(function(a:
Icon__DARKLUA_TYPE_l):Icon__DARKLUA_TYPE_l return nil::any end),deselect:typeof(
function(a:Icon__DARKLUA_TYPE_l):Icon__DARKLUA_TYPE_l return nil::any end),
notify:typeof(function(a:Icon__DARKLUA_TYPE_l,b:Signal__DARKLUA_TYPE_c?):
Icon__DARKLUA_TYPE_l return nil::any end),clearNotices:typeof(function(a:
Icon__DARKLUA_TYPE_l):Icon__DARKLUA_TYPE_l return nil::any end),disableOverlay:
typeof(function(a:Icon__DARKLUA_TYPE_l,b:boolean):Icon__DARKLUA_TYPE_l return
nil::any end),setImage:typeof(function(a:Icon__DARKLUA_TYPE_l,b:string|number,c:
IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l return nil::any end),setLabel:
typeof(function(a:Icon__DARKLUA_TYPE_l,b:string,c:IconState__DARKLUA_TYPE_d?):
Icon__DARKLUA_TYPE_l return nil::any end),setOrder:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:number,c:IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l
return nil::any end),setCornerRadius:typeof(function(a:Icon__DARKLUA_TYPE_l,b:
UDim2,c:IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l return nil::any end),
align:typeof(function(a:Icon__DARKLUA_TYPE_l,b:Alignment__DARKLUA_TYPE_f?):
Icon__DARKLUA_TYPE_l return nil::any end),setWidth:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:number,c:IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l
return nil::any end),setImageScale:typeof(function(a:Icon__DARKLUA_TYPE_l,b:
number,c:IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l return nil::any end),
setImageRatio:typeof(function(a:Icon__DARKLUA_TYPE_l,b:number,c:
IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l return nil::any end),
setTextSize:typeof(function(a:Icon__DARKLUA_TYPE_l,b:number,c:
IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l return nil::any end),
setTextColor:typeof(function(a:Icon__DARKLUA_TYPE_l,b:Color3,c:
IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l return nil::any end),
setTextFont:typeof(function(a:Icon__DARKLUA_TYPE_l,b:string|Enum.Font,c:Enum.
FontWeight?,d:Enum.FontSize?,e:IconState__DARKLUA_TYPE_d?):Icon__DARKLUA_TYPE_l
return nil::any end),bindToggleItem:typeof(function(a:Icon__DARKLUA_TYPE_l,b:
GuiObject|LayerCollector):Icon__DARKLUA_TYPE_l return nil::any end),
unbindToggleItem:typeof(function(a:Icon__DARKLUA_TYPE_l,b:GuiObject|
LayerCollector):Icon__DARKLUA_TYPE_l return nil::any end),bindEvent:typeof(
function(a:Icon__DARKLUA_TYPE_l,b:Events__DARKLUA_TYPE_e,c:(...any)->()):
Icon__DARKLUA_TYPE_l return nil::any end),unbindEvent:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:Events__DARKLUA_TYPE_e):Icon__DARKLUA_TYPE_l return nil::
any end),bindToggleKey:typeof(function(a:Icon__DARKLUA_TYPE_l,b:Enum.KeyCode):
Icon__DARKLUA_TYPE_l return nil::any end),unbindToggleKey:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:Enum.KeyCode):Icon__DARKLUA_TYPE_l return nil::any end),
call:typeof(function(a:Icon__DARKLUA_TYPE_l,b:(self:Icon__DARKLUA_TYPE_l)->(...
any),...:any):Icon__DARKLUA_TYPE_l return nil::any end),addToJanitor:typeof(
function(a:Icon__DARKLUA_TYPE_l,b:unknown):Icon__DARKLUA_TYPE_l return nil::any
end),lock:typeof(function(a:Icon__DARKLUA_TYPE_l):Icon__DARKLUA_TYPE_l return
nil::any end),unlock:typeof(function(a:Icon__DARKLUA_TYPE_l):
Icon__DARKLUA_TYPE_l return nil::any end),debounce:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:number):Icon__DARKLUA_TYPE_l return nil::any end),
autoDeselect:typeof(function(a:Icon__DARKLUA_TYPE_l,b:boolean?):
Icon__DARKLUA_TYPE_l return nil::any end),oneClick:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:boolean?):Icon__DARKLUA_TYPE_l return nil::any end),
setCaption:typeof(function(a:Icon__DARKLUA_TYPE_l,b:string?):
Icon__DARKLUA_TYPE_l return nil::any end),setCaptionHint:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:Enum.KeyCode):Icon__DARKLUA_TYPE_l return nil::any end),
setDropdown:typeof(function(a:Icon__DARKLUA_TYPE_l,b:{Icon__DARKLUA_TYPE_l}):
Icon__DARKLUA_TYPE_l return nil::any end),joinDropdown:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:Icon__DARKLUA_TYPE_l):Icon__DARKLUA_TYPE_l return nil::
any end),setMenu:typeof(function(a:Icon__DARKLUA_TYPE_l,b:{Icon__DARKLUA_TYPE_l}
):Icon__DARKLUA_TYPE_l return nil::any end),setFixedMenu:typeof(function(a:
Icon__DARKLUA_TYPE_l,b:{Icon__DARKLUA_TYPE_l}):Icon__DARKLUA_TYPE_l return nil::
any end),joinMenu:typeof(function(a:Icon__DARKLUA_TYPE_l,b:Icon__DARKLUA_TYPE_l)
:Icon__DARKLUA_TYPE_l return nil::any end),leave:typeof(function(a:
Icon__DARKLUA_TYPE_l):Icon__DARKLUA_TYPE_l return nil::any end),
convertLabelToNumberSpinner:typeof(function(a:Icon__DARKLUA_TYPE_l,b:any,c:(...
any)->(...any),...:any):Icon__DARKLUA_TYPE_l return nil::any end),destroy:
typeof(function(a:Icon__DARKLUA_TYPE_l):Icon__DARKLUA_TYPE_l return nil::any end
)}&StaticFunctions__DARKLUA_TYPE_i type Fields__DARKLUA_TYPE_k={name:string,
isSelected:boolean,isEnabled:boolean,totalNotices:number,locked:boolean,selected
:Signal__DARKLUA_TYPE_c<EventSource__DARKLUA_TYPE_g>,deselected:
Signal__DARKLUA_TYPE_c<EventSource__DARKLUA_TYPE_g>,toggled:
Signal__DARKLUA_TYPE_c<boolean,EventSource__DARKLUA_TYPE_g>,viewingStarted:
Signal__DARKLUA_TYPE_c,viewingEnded:Signal__DARKLUA_TYPE_c,notified:
Signal__DARKLUA_TYPE_c}type Icon__DARKLUA_TYPE_l=Methods__DARKLUA_TYPE_j&
StaticFunctions__DARKLUA_TYPE_i type StaticIcon__DARKLUA_TYPE_m={new:typeof(
function():Icon__DARKLUA_TYPE_l return(nil::any)::Icon__DARKLUA_TYPE_l end)}&
StaticFunctions__DARKLUA_TYPE_i local a={cache={}::any}do do local b=function()
local b local c=function(c,...)local d=b b=nil c(...)b=d end local d,e=function(
)while true do c(coroutine.yield())end end,{}e.__index=e function e.new(f,g)
return setmetatable({_connected=true,_signal=f,_fn=g,_next=false},e)end function
e:Disconnect()self._connected=false if self._signal._handlerListHead==self then
self._signal._handlerListHead=self._next else local f=self._signal.
_handlerListHead while f and f._next~=self do f=f._next end if f then f._next=
self._next end end end e.Destroy=e.Disconnect setmetatable(e,{__index=function(f
,g)error(('Attempt to get Connection::%s (not a valid member)'):format(tostring(
g)),2)end,__newindex=function(f,g,h)error((
'Attempt to set Connection::%s (not a valid member)'):format(tostring(g)),2)end}
)local f={}f.__index=f function f.new()return setmetatable({_handlerListHead=
false},f)end function f:Connect(g)local h=e.new(self,g)if self._handlerListHead
then h._next=self._handlerListHead self._handlerListHead=h else self.
_handlerListHead=h end return h end function f:DisconnectAll()self.
_handlerListHead=false end f.Destroy=f.DisconnectAll function f:Fire(...)local g
=self._handlerListHead while g do if g._connected then if not b then b=coroutine
.create(d)coroutine.resume(b)end task.spawn(b,g._fn,...)end g=g._next end end
function f:Wait()local g,h=(coroutine.running())h=self:Connect(function(...)h:
Disconnect()task.spawn(g,...)end)return coroutine.yield()end function f:Once(g)
local h h=self:Connect(function(...)if h._connected then h:Disconnect()end g(...
)end)return h end setmetatable(f,{__index=function(g,h)error((
'Attempt to get Signal::%s (not a valid member)'):format(tostring(h)),2)end,
__newindex=function(g,h,i)error((
'Attempt to set Signal::%s (not a valid member)'):format(tostring(h)),2)end})
return f end function a.a():typeof(b())local c=a.cache.a if not c then c={c=b()}
a.cache.a=c end return c.c end end do local b=function()local b=game:GetService
'RunService'local c,d,e=b.Heartbeat,function()return false end,newproxy(true)
getmetatable(e).__tostring=function()return'IndicesReference'end local f=
newproxy(true)getmetatable(f).__tostring=function()return'LinkToInstanceIndex'
end local g,h,i,j=
[[Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s]]
,[[Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))]]
,{IGNORE_MEMORY_DEBUG=true,ClassName='Janitor',__index={CurrentlyCleaning=true,[
e]=nil}},{['function']=true,Promise='cancel',RBXScriptConnection='Disconnect'}
function i.new()return setmetatable({CurrentlyCleaning=false,[e]=nil},i)end
function i.Is(k)return type(k)=='table'and getmetatable(k)==i end i.is=i.Is
function i.__index:Add(k,l,m)if m then self:Remove(m)local n=self[e]if not n
then n={}self[e]=n end n[m]=k end local n=typeof(k)if n=='table'and string.
match(tostring(k),'Promise')then n='Promise'end l=l or j[n]or'Destroy'if type(k)
~='function'and not k[l]then warn(string.format(g,tostring(k),tostring(l),debug.
traceback(nil::any,2)))end local o=debug.traceback''self[k]={l,o}return k end i.
__index.Give=i.__index.Add function i.__index:AddPromise(k)local l=d()if l then
if not l.is(k)then error(string.format(h,typeof(k),tostring(k)))end if k:
getStatus()==l.Status.Started then local m=newproxy(false)local n=self:Add(l.
new(function(n,o,p)if p(function()k:cancel()end)then return end n(k)end),
'cancel',m)n:finallyCall(self.Remove,self,m)return n else return k end else
return k end end i.__index.GivePromise=i.__index.AddPromise function i.__index:
AddObject(k)local l,m=newproxy(false),d()if m and m.is(k)then if k:getStatus()==
m.Status.Started then local n=self:Add(m.resolve(k),'cancel',l)n:finallyCall(
self.Remove,self,l)return n,l else return k end else return self:Add(k,false,l),
l end end i.__index.GiveObject=i.__index.AddObject function i.__index:Remove(k)
local l=self[e]if l then local m=l[k]if m then local n=self[m]local o=n and n[1]
if o then if o==true then m()else local p=m[o]if p then p(m)end end self[m]=nil
end l[k]=nil end end return self end function i.__index:Get(k)local l=self[e]if
l then return l[k]end return nil end function i.__index:Cleanup()if not self.
CurrentlyCleaning then self.CurrentlyCleaning=nil for k,l in next,self do if k==
e then continue end local m=type(k)if m=='string'or m=='number'then self[k]=nil
continue end local n,o=l[1],l[2]local p=function(p)local q,r=debug.traceback('',
3),o warn('-------- Janitor Error --------'..'\n'..tostring(p)..'\n'..q..''..r)
end if n==true then local q,r=pcall(k)if not q then p(r)end else local q=k[n]if
q then local r,s=pcall(q,k)local t=typeof(k)=='Instance'and q=='Destroy'if not r
and not t then p(s)end end end self[k]=nil end local k=self[e]if k then for l in
next,k do k[l]=nil end self[e]={}end self.CurrentlyCleaning=false end end i.
__index.Clean=i.__index.Cleanup function i.__index:Destroy()self:Cleanup()end i.
__call=i.__index.Cleanup local k={Connected=true}k.__index=k function k:
Disconnect()if self.Connected then self.Connected=false self.Connection:
Disconnect()end end function k:__tostring()return'Disconnect<'..tostring(self.
Connected)..'>'end function i.__index:LinkToInstance(l,m)local n,o,p,q=m and
newproxy(false)or f,l.Parent==nil,(setmetatable({},k))local r=function(r,s)if p.
Connected then r=nil o=s==nil if o then coroutine.wrap(function()c:Wait()if not
p.Connected then return elseif not q.Connected then self:Cleanup()else while o
and q.Connected and p.Connected do c:Wait()end if p.Connected and o then self:
Cleanup()end end end)()end end end q=l.AncestryChanged:Connect(r)p.Connection=q
if o then r(nil,l.Parent)end l=nil return self:Add(p,'Disconnect',n)end function
i.__index:LinkToInstances(...)local l=i.new()for m,n in ipairs{...}do l:Add(self
:LinkToInstance(n,true),'Disconnect')end return l end for l,m in next,i.__index
do local n=string.sub(string.lower(l),1,1)..string.sub(l,2)i.__index[n]=m end
return i end function a.b():typeof(b())local c=a.cache.b if not c then c={c=b()}
a.cache.b=c end return c.c end end do local b=function()local b,c={},game:
GetService'Players'local d=c.LocalPlayer b.Clone=function(e:any)local f:any if
type(e)=='function'then f=clonefunction and clonefunction(e)elseif typeof(e)==
'Instance'then f=cloneref and cloneref(e)end return f or e end b.ProtectUI=
function(e:Instance?):Instance|string local f,g=pcall(function()return gethui()
end)local h,i=pcall(function()local h=b.Clone(game:GetService'CoreGui')if h and
h.ClassName then return h end return end)local j=f and g or h and i or b.Clone(
game:GetService'Players').LocalPlayer.PlayerGui if e then local k,l=pcall(
function()e.Parent=j end)return k and e or l end return j end function b.
createStagger(e,f,g)local h,i=false,false if not e or e==0 then e=0.01 end
local function j(...)if h then i=true return end local k=table.pack(...)h=true i
=false task.spawn(function()if g then task.wait(e)end f(table.unpack(k))end)task
.delay(e,function()h=false if i then j(table.unpack(k))end end)end return j end
function b.round(e)return math.floor(e+0.5)end function b.reverseTable(e)for f=1
,math.floor(#e/2)do local g=#e-f+1 e[f],e[g]=e[g],e[f]end end function b.
copyTable(e)assert(type(e)=='table','First argument must be a table')local f=
table.create(#e)for g,h in pairs(e)do if(type(h)=='table')then f[g]=b.copyTable(
h)else f[g]=h end end return f end local e={'a','b','c','d','e','f','g','h','i',
'j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C',
'D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W',
'X','Y','Z','1','2','3','4','5','6','7','8','9','0','<','>','?','@','{','}','[',
']','!','(',')','=','+','~','#'}function b.generateUID(f)f=f or 8 local g,h='',e
local i=#h for j=1,f do local k=h[math.random(1,i)]g=g..k end return g end local
f={}function b.setVisible(g,h,i)local j=f[g]if not j then j={}f[g]=j g.
Destroying:Once(function()f[g]=nil end)end if not h then j[i]=true else j[i]=nil
end local k=h if h then for l,m in pairs(j)do k=false break end end g.Visible=k
end function b.formatStateName(g)return string.upper(string.sub(g,1,1))..string.
lower(string.sub(g,2))end function b.localPlayerRespawned(g)d.CharacterRemoving:
Connect(g)end function b.getClippedContainer(g)local h=g:FindFirstChild
'ClippedContainer'if not h then h=Instance.new'Folder'h.Name='ClippedContainer'h
.Parent=g end return h end local g,h=a.b(),game:GetService'GuiService'function b
.clipOutside(i,j)local k=i.janitor:add(g.new())j.Destroying:Once(function()k:
Destroy()end)i.janitor:add(j)local l,m=j.Parent,k:add(Instance.new'Frame')m:
SetAttribute('IsAClippedClone',true)m.Name=j.Name m.AnchorPoint=j.AnchorPoint m.
Size=j.Size m.Position=j.Position m.BackgroundTransparency=1 m.LayoutOrder=j.
LayoutOrder m.Parent=l local n=Instance.new'ObjectValue'n.Name=
'OriginalInstance'n.Value=j n.Parent=m local o=n:Clone()j:SetAttribute(
'HasAClippedClone',true)o.Name='ClippedClone'o.Value=m o.Parent=j local p,q=(i.
_iconRef)local r=p.container local s=function()local s=l and l:
FindFirstAncestorWhichIsA'ScreenGui'if not s then return end if string.match(s.
Name,'Clipped')then q=s return end q=r[s.Name..'Clipped']or s j.AnchorPoint=
Vector2.new(0,0)j.Parent=b.getClippedContainer(q)end k:add(i.alignmentChanged:
Connect(s))s()for t,u in pairs(j:GetChildren())do if u:IsA
'UIAspectRatioConstraint'then u:Clone().Parent=m end end local t,u,v=i.widget,
false,j:GetAttribute'IgnoreVisibilityUpdater'local w=function()if v then return
end local w=t.Visible if u then w=false end b.setVisible(j,w,'ClipHandler')end k
:add(t:GetPropertyChangedSignal'Visible':Connect(w))local x local function y()
task.defer(function()local z,A=(i.UID)local B,C=z,j:GetAttribute
'ClipToJoinedParent'if C then for D=1,10 do local E=p.getIconByUID(B)if not E
then break end local F=E.joinedFrame B=E.parentIconUID if not F then break end A
=F if A and A.Name=='DropdownScroller'then break end end end if not A then u=
false w()return end local D,E,F,G=j.AbsolutePosition,j.AbsoluteSize/2,A.
AbsolutePosition,A.AbsoluteSize local H=(D+E)local I,J,K,L=H.X<F.X,H.X>(F.X+G.X)
,H.Y<F.Y,H.Y>(F.Y+G.Y)local M=I or J or K or L if M~=u then u=M w()end if A:IsA
'ScrollingFrame'and x~=A then x=A local N=A:GetPropertyChangedSignal
'AbsoluteWindowSize':Connect(function()y()end)k:add(N,'Disconnect',
'TrackUtilityScroller-'..z)end end)end local z,A=workspace.CurrentCamera,j:
GetAttribute'AdditionalOffsetX'or 0 local B=function(B)local C='Absolute'..B
local D=function()local D=m[C]local E=UDim2.fromOffset(D.X,D.Y)if B=='Position'
then local F=4 local G,H=z.ViewportSize.X-j.AbsoluteSize.X-F,E.X.Offset if H<F
then H=F elseif H>G then H=G end E=UDim2.fromOffset(H,E.Y.Offset)local I,J,K,L,M
=h.TopbarInset,workspace.CurrentCamera.ViewportSize.X,q.AbsoluteSize.X,q.
AbsolutePosition.X,0 local N=(p.isOldTopbar and{L}or{(J-K-M)})[1]N-=A E+=UDim2.
fromOffset(-N,I.Height)y()end j[B]=E end local E=b.createStagger(0.01,D)k:add(m:
GetPropertyChangedSignal(C):Connect(E))k:add(m:GetAttributeChangedSignal
'ForceUpdate':Connect(function()E()end))local F=b.createStagger(0.5,D,true)k:
add(m:GetPropertyChangedSignal(C):Connect(F))if B=='Position'then k:add(q:
GetPropertyChangedSignal'AbsoluteSize':Connect(function()E()end))end end task.
delay(0.1,y)y()w()B'Position'k:add(j:GetPropertyChangedSignal'Visible':Connect(
function()end))local C=j:GetAttribute'TrackCloneSize'if C then B'Size'else k:
add(j:GetPropertyChangedSignal'AbsoluteSize':Connect(function()local D=j.
AbsoluteSize m.Size=UDim2.fromOffset(D.X,D.Y)end))end return m end function b.
joinFeature(i,j,k,l)local m=i.joinJanitor m:Cleanup()if not l then i:leave()
return end i.parentIconUID=j.UID i.joinedFrame=l local n=function()local n=j.
alignment if n=='Center'then n='Left'end i:setAlignment(n,true)end m:add(j.
alignmentChanged:Connect(n))n()i:modifyTheme({'IconButton',
'BackgroundTransparency',1},'JoinModification')i:modifyTheme({'ClickRegion',
'Active',false},'JoinModification')if j.childModifications then task.defer(
function()i:modifyTheme(j.childModifications,j.childModificationsUID)end)end
local o=i:getInstance'ClickRegion'local p=function()o.Selectable=j.isSelected
end m:add(j.toggled:Connect(p))task.defer(p)m:add(function()o.Selectable=true
end)local q=i.UID table.insert(k,q)j:autoDeselect(false)j.childIconsDict[q]=true
if not j.isEnabled then j:setEnabled(true)end i.joinedParent:Fire(j)m:add(
function()local r=i.joinedFrame if not r then return end for s,t in pairs(k)do
if t==q then table.remove(k,s)break end end local s=i._iconRef local t=s.
getIconByUID(i.parentIconUID)if not t then return end i:setAlignment(i.
originalAlignment)i.parentIconUID=false i.joinedFrame=false i:removeModification
'JoinModification'local u,v=true,t.childIconsDict v[q]=nil for w,x in pairs(v)do
u=false break end if u and not t.isAnOverflow then t:setEnabled(false)end n()end
)end return b end function a.c():typeof(b())local c=a.cache.c if not c then c={c
=b()}a.cache.c=c end return c.c end end do local b=function()return{{
'IconCorners','CornerRadius',UDim.new(1,0)},{'Selection','RotationSpeed',1},{
'Selection','Size',UDim2.new(1,0,1,1)},{'Selection','Position',UDim2.new(0,0,0,0
)},{'SelectionGradient','Color',ColorSequence.new{ColorSequenceKeypoint.new(0,
Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(86,86,86
))}},{'IconImage','Image','','Deselected'},{'IconLabel','Text','','Deselected'},
{'IconLabel','Position',UDim2.fromOffset(0,0),'Deselected'},{'Widget',
'DesiredWidth',44,'Deselected'},{'Widget','MinimumWidth',44,'Deselected'},{
'Widget','MinimumHeight',44,'Deselected'},{'Widget','BorderSize',4,'Deselected'}
,{'IconButton','BackgroundColor3',Color3.fromRGB(18,18,21),'Deselected'},{
'IconButton','BackgroundTransparency',0.08,'Deselected'},{'IconImageScale',
'Value',0.5,'Deselected'},{'IconImageCorner','CornerRadius',UDim.new(0,0),
'Deselected'},{'IconImage','ImageColor3',Color3.fromRGB(255,255,255),
'Deselected'},{'IconImage','ImageTransparency',0,'Deselected'},{'IconImageRatio'
,'AspectRatio',1,'Deselected'},{'IconLabel','FontFace',Font.new(
'rbxasset://fonts/families/BuilderSans.json',Enum.FontWeight.Bold,Enum.FontStyle
.Normal),'Deselected'},{'IconLabel','TextSize',16,'Deselected'},{'IconSpot',
'BackgroundTransparency',1,'Deselected'},{'IconOverlay','BackgroundTransparency'
,0.85,'Deselected'},{'IconSpotGradient','Enabled',false,'Deselected'},{
'IconGradient','Enabled',false,'Deselected'},{'ClickRegion','Active',true,
'Deselected'},{'Menu','Active',false,'Deselected'},{'ContentsList',
'HorizontalAlignment',Enum.HorizontalAlignment.Center,'Deselected'},{'Dropdown',
'BackgroundColor3',Color3.fromRGB(18,18,21),'Deselected'},{'Dropdown',
'BackgroundTransparency',0.08,'Deselected'},{'Dropdown','MaxIcons',4.5,
'Deselected'},{'Menu','MaxIcons',4,'Deselected'},{'Notice','Position',UDim2.new(
1,-12,0,-1),'Deselected'},{'Notice','Size',UDim2.new(0,20,0,20),'Deselected'},{
'NoticeLabel','TextSize',13,'Deselected'},{'PaddingLeft','Size',UDim2.new(0,9,1,
0),'Deselected'},{'PaddingRight','Size',UDim2.new(0,11,1,0),'Deselected'},{
'IconSpot','BackgroundTransparency',0.7,'Selected'},{'IconSpot',
'BackgroundColor3',Color3.fromRGB(255,255,255),'Selected'},{'IconSpotGradient',
'Enabled',true,'Selected'},{'IconSpotGradient','Rotation',45,'Selected'},{
'IconSpotGradient','Color',ColorSequence.new(Color3.fromRGB(96,98,100),Color3.
fromRGB(77,78,80)),'Selected'}}end function a.d():typeof(b())local c=a.cache.d
if not c then c={c=b()}a.cache.d=c end return c.c end end do local b=function()
local b,c,d={},a.c(),a.d()function b.getThemeValue(e,f,g,h)if e then for i,j in
pairs(e)do local k,l,m=unpack(j)if f==k and g==l then return m end end end
return nil end function b.getInstanceValue(e,f)local g,h=pcall(function()return
e[f]end)if not g then h=e:GetAttribute(f)end return h end function b.
getRealInstance(e)if not e:GetAttribute'IsAClippedClone'then return end local f=
e:FindFirstChild'OriginalInstance'if not f then return end return f.Value end
function b.getClippedClone(e)if not e:GetAttribute'HasAClippedClone'then return
end local f=e:FindFirstChild'ClippedClone'if not f then return end return f.
Value end function b.refresh(e,f,g)if g then local h=e:getStateGroup()local i=b.
getThemeValue(h,f.Name,g)or b.getInstanceValue(f,g)b.apply(e,f,g,i,true)return
end local h=e:getStateGroup()if not h then return end local i={[f.Name]=f}for j,
k in pairs(f:GetDescendants())do local l=k:GetAttribute'Collective'if l then i[l
]=k end i[k.Name]=k end for j,k in pairs(h)do local l,m,n=unpack(k)local o=i[l]
if o then b.apply(e,o.Name,m,n,true)end end return end function b.apply(e,f,g,h,
i)if e.isDestroyed then return end local j,k=f if typeof(f)=='Instance'then k={f
}j=f.Name else k=e:getInstanceOrCollective(f)end local l=j..'-'..g local m=e.
customBehaviours[l]for n,o in pairs(k)do local p=b.getClippedClone(o)if p then
table.insert(k,p)end end for n,o in pairs(k)do if g=='Position'and b.
getClippedClone(o)then continue elseif g=='Size'and b.getRealInstance(o)then
continue end local p=b.getInstanceValue(o,g)if not i and h==p then continue end
if m then local q=m(h,o,g)if q~=nil then h=q end end local q=pcall(function()o[g
]=h end)if not q then o:SetAttribute(g,h)end end end function b.getModifications
(e)if typeof(e[1])~='table'then e={e}end return e end function b.merge(e,f,g)
local h,i,j,k=table.unpack(f)local l,m,n,o=table.unpack(e)if h==l and i==m and b
.statesMatch(k,o)then e[3]=j if g then g(e)end return true end return false end
function b.modify(e,f,g)task.spawn(function()g=g or c.generateUID()f=b.
getModifications(f)for h,i in pairs(f)do local j,k,l,m=table.unpack(i)if m==nil
then b.modify(e,{j,k,l,'Selected'},g)b.modify(e,{j,k,l,'Viewing'},g)end local n=
c.formatStateName(m or'Deselected')local o,p=e:getStateGroup(n),function()if n==
e.activeState then b.apply(e,j,k,l)end end local q=function()for q,r in pairs(o)
do local s=b.merge(r,i,function(s)s[5]=g p()end)if s then return end end local q
={j,k,l,n,g}table.insert(o,q)p()end q()end end)return g end function b.remove(e,
f)for g,h in pairs(e.appearance)do for i=#h,1,-1 do local j=h[i]local k=j[5]if k
==f then table.remove(h,i)end end end b.rebuild(e)end function b.removeWith(e,f,
g,h)for i,j in pairs(e.appearance)do if h==i or not h then for k=#j,1,-1 do
local l=j[k]local m,n=l[1],l[2]if m==f and n==g then table.remove(j,k)end end
end end b.rebuild(e)end function b.change(e)local f=e:getStateGroup()for g,h in
pairs(f)do local i,j,k=unpack(h)b.apply(e,i,j,k)end end function b.set(e,f)local
g=e.themesJanitor g:Cleanup()g:add(e.stateChanged:Connect(function()b.change(e)
end))e.appliedTheme=f b.rebuild(e)end function b.statesMatch(e,f)local g,h=(e
and string.lower(e)),(f and string.lower(f))return g==h or not e or not f end
function b.rebuild(e)local f,g=e.appliedTheme,{'Deselected','Selected','Viewing'
}local h=function()for h,i in pairs(g)do local j={}local k=function(k,l)if not k
then return end for m,n in pairs(k)do local o,p=n[5],n[4]if b.statesMatch(l,p)
then local q,r=n[1]..'-'..n[2],c.copyTable(n)r[5]=o j[q]=r end end end if i==
'Selected'then k(d,'Deselected')end k(d,'Empty')k(d,i)if f~=d then if i==
'Selected'then k(f,'Deselected')end k(d,'Empty')k(f,i)end local l,m={},e.
appearance[i]if m then for n,o in pairs(m)do local p=o[5]if p~=nil then local q=
{o[1],o[2],o[3],i,p}table.insert(l,q)end end end k(l,i)local n={}for o,p in
pairs(j)do table.insert(n,p)end e.appearance[i]=n end b.change(e)end h()end
return b end function a.e():typeof(b())local c=a.cache.e if not c then c={c=b()}
a.cache.e=c end return c.c end end do local b=function()return function(b)local
c=Instance.new'Frame'c.Name='SelectionContainer'c.Visible=false local d=Instance
.new'Frame'd.Name='Selection'd.BackgroundColor3=Color3.fromRGB(255,255,255)d.
BackgroundTransparency=1 d.BorderColor3=Color3.fromRGB(0,0,0)d.BorderSizePixel=0
d.Parent=c local e=Instance.new'UIStroke'e.Name='UIStroke'e.ApplyStrokeMode=Enum
.ApplyStrokeMode.Border e.Color=Color3.fromRGB(255,255,255)e.Thickness=3 e.
Parent=d local f=Instance.new'UIGradient'f.Name='SelectionGradient'f.Parent=e
local g=Instance.new'UICorner'g:SetAttribute('Collective','IconCorners')g.Name=
'UICorner'g.CornerRadius=UDim.new(1,0)g.Parent=d local h,i,j=game:GetService
'RunService',game:GetService'GuiService',1 d:GetAttributeChangedSignal
'RotationSpeed':Connect(function()j=d:GetAttribute'RotationSpeed'end)h.Heartbeat
:Connect(function()if not i.SelectedObject then return end f.Rotation=(os.clock(
)*j*100)%360 end)return c end end function a.f():typeof(b())local c=a.cache.f if
not c then c={c=b()}a.cache.f=c end return c.c end end do local b=function()
local b,c,d,e,f,g,h=game:GetService'GamepadService',game:GetService
'UserInputService',game:GetService'GuiService',Enum.KeyCode.DPadUp,Enum.
PreferredInput.Gamepad,{}function g.start(i)h=i h.highlightKey=(h.highlightKey~=
nil and{(h.highlightKey)}or{e})[1]h.highlightIcon=false task.delay(1,function()
local j=h.iconsDictionary local k,l,m,n,o=function()local k=d.SelectedObject
local l=k and k:GetAttribute'CorrespondingIconUID'local m=l and j[l]return m end
,e~=h.highlightKey,e~=h.highlightKey,(a.f())local p=function()local p,q=k(),c.
PreferredInput==f if p then if q then local r,s=p:getInstance'ClickRegion',p.
selection if not s then s=p.janitor:add(n(h))s:SetAttribute(
'IgnoreVisibilityUpdater',true)s.Parent=p.widget p.selection=s p:
refreshAppearance(s)end r.SelectionImageObject=s.Selection end if o and o~=p
then o:setIndicator()end local r=(q and not m and not p.parentIconUID and{(Enum.
KeyCode.ButtonB)}or{nil})[1]o=p h.lastHighlightedIcon=p p:setIndicator(r)else
local r=(q and not l and{(h.highlightKey)}or{nil})[1]if not o then o=g.
getIconToHighlight()end if r==h.highlightKey then l=true end if o then o:
setIndicator(r)end end end d:GetPropertyChangedSignal'SelectedObject':Connect(p)
local q=function()local q=c.PreferredInput local r=q==f if not r then l=false m=
false end p()end c:GetPropertyChangedSignal'PreferredInput':Connect(q)q()c.
InputBegan:Connect(function(r,s)if r.UserInputType==Enum.UserInputType.
MouseButton1 then local t=k()if t then d.SelectedObject=nil end return end if r.
KeyCode~=h.highlightKey then return end local t=g.getIconToHighlight()if t then
if b.GamepadCursorEnabled then task.wait(0.2)b:DisableGamepadCursor()end local u
=t:getInstance'ClickRegion'd.SelectedObject=u end end)end)end function g.
getIconToHighlight()local i,j=h.iconsDictionary,h.highlightIcon or h.
lastHighlightedIcon if not j then local k for l,m in pairs(i)do if m.
parentIconUID then continue end local n=m.widget.AbsolutePosition.X if not k or
n<k then j=m k=j.widget.AbsolutePosition.X end end end return j end function g.
registerButton(i)local j=false i.InputBegan:Connect(function(k)j=true task.wait(
)task.wait()j=false end)local k=c.InputBegan:Connect(function(k)task.wait()if k.
KeyCode==Enum.KeyCode.ButtonA and j then task.wait(0.2)b:DisableGamepadCursor()d
.SelectedObject=i return end local l,m,n=d.SelectedObject==i,{'ButtonB',
'ButtonSelect'},k.KeyCode.Name if table.find(m,n)and l then if not(n==
'ButtonSelect'and not b.GamepadCursorEnabled)then d.SelectedObject=nil end end
end)i.Destroying:Once(function()k:Disconnect()end)end return g end function a.g(
):typeof(b())local c=a.cache.g if not c then c={c=b()}a.cache.g=c end return c.c
end end do local b=function()local b=a.c()local c,d,e,f,g,h,i,j,k=b.Clone(game:
GetService'Players'),{},{},{},workspace.CurrentCamera,{},{}local l=function(l)
local m,n={}for o,p in ipairs(l:GetChildren())do if p:IsA'ScreenGui'then if n==
nil and p.ScreenInsets==Enum.ScreenInsets.TopbarSafeInsets then n=p end local q=
p:FindFirstChild'Holders'if q then for r,s in ipairs(q:GetChildren())do if s:
GetAttribute'IsAHolder'then m[s.Name]=s end end end end end return m,n end local
m=function()local m,n,o,p={},{b.ProtectUI()},(c.LocalPlayer)if o then local q=o:
FindFirstChildOfClass'PlayerGui'if q then table.insert(n,q)end end for q,r in
ipairs(n)do local s,t=l(r)if t and not p then p=t end for u,v in pairs(s)do if
not m[u]then m[u]=v end end end return m,p end function d.start(n)k=n j=k.
iconsDictionary local o,p,q=false local r,s=function(r,s)if not r or not next(r)
then return false end e=r p=s k.topbarHoldersOverride=r k.
topbarPrimaryScreenGuiOverride=s for t,u in pairs(j)do if u and u.alignment and
u.alignment~=''then u:align(u.alignment,true)else u:align('Left',true)end end
return true end,function()if p and not p:GetAttribute'__TopbarPlusOverflowBound'
then p:SetAttribute('__TopbarPlusOverflowBound',true)p:GetPropertyChangedSignal
'AbsoluteSize':Connect(function()q(true)end)end end local t=function()if o then
return end o=true s()q()end q=b.createStagger(0.1,function(u)if not o then
return end if not u then d.updateAvailableIcons'Center'end d.updateBoundary
'Left'd.updateBoundary'Right'end)local u,v,w=function()if o then return end
local u,v=m()if r(u,v)then t()end end,m()if r(v,w)then t()else local x=function(
x)x.DescendantAdded:Connect(function(y)if o then return end if y:IsA'ScreenGui'
or y.Name=='Holders'or y:GetAttribute'IsAHolder'then u()end end)end x(b.
ProtectUI())local y=c.LocalPlayer if y then local z=y:FindFirstChildOfClass
'PlayerGui'if z then x(z)end else c.PlayerAdded:Connect(function(z)if z~=c.
LocalPlayer then return end z.ChildAdded:Connect(function(A)if A:IsA'PlayerGui'
then x(A)u()end end)end)end task.spawn(function()for z=1,8 do if o then break
end task.wait(0.25)u()end if not o then o=true warn
[[[TopbarPlusPlus] Overflow: could not find topbar holders after 2s; overflow may be incorrect.]]
q()end end)end k.iconAdded:Connect(q)k.iconRemoved:Connect(q)k.iconChanged:
Connect(q)g:GetPropertyChangedSignal'ViewportSize':Connect(function()q(true)end)
end function d.getWidth(n,o)local p=n.widget return p:GetAttribute'TargetWidth'
or p.AbsoluteSize.X end function d.getAvailableIcons(n)local o=f[n]if not o then
o=d.updateAvailableIcons(n)end return o end function d.updateAvailableIcons(n)
local o,p=0,{}for q,r in pairs(j)do local s=r.parentIconUID local t,u=not s or i
[s],i[r.UID]if t and r.alignment==n and not u and r.isEnabled then table.insert(
p,r)o+=1 end end if o<=0 then return{}end table.sort(p,function(q,r)local s,t,u,
v=q.widget.LayoutOrder,r.widget.LayoutOrder,q.parentIconUID,r.parentIconUID if u
==v then if s<t then return true end if s>t then return false end return q.
widget.AbsolutePosition.X<r.widget.AbsolutePosition.X elseif v then return false
elseif u then return true end return nil end)f[n]=p return p end function d.
getRealXPositions(n,o)local p,q=n=='Left',e[n]local r,s,t=q.AbsolutePosition.X,q
.AbsoluteSize.X,q.UIListLayout local u,v,w=t.Padding.Offset,(p and r)or r+s,{}if
p then b.reverseTable(o)end for x=#o,1,-1 do local y=o[x]local z=d.getWidth(y)if
not p then v-=z end w[y.UID]=v if p then v+=z end v+=(p and u)or-u end return w
end function d.updateBoundary(n)local o=e[n]if not o then return end local p,q,r
=o.UIListLayout,o.AbsolutePosition.X,o.AbsoluteSize.X local s,t=p.Padding.Offset
,p.Padding.Offset local u,v,w,x=s,d.updateAvailableIcons(n),0,0 for y,z in
pairs(v)do w+=d.getWidth(z)+t x+=1 end if x<=0 then return end local y,z=n==
'Center',n=='Left'local A,B=not z,h[n]if not B and not y and#v>0 then local C=(z
and-9999999)or 9999999 B=k.new()B:setImage(6069276526,'Deselected')B:setName(
'Overflow'..n)B:setOrder(C)B:setAlignment(n)B:autoDeselect(false)B.isAnOverflow=
true B:select('OverflowStart',B)B:setEnabled(false)h[n]=B i[B.UID]=true if not k
.closeableOverflowMenus then local D=B:getInstance'IconSpot'D.Visible=false end
end local C=(n=='Left'and'Right')or'Left'local D,E=e[C],d.updateAvailableIcons(C
)local F,G,H,I=(z and E[1])or(A and E[#E]),h[C],(z and q+r)or q,k and k.
topbarHoldersOverride==e if I and D then if z then local J for K,L in ipairs(D:
GetChildren())do if L:IsA'GuiObject'and L.Visible and L.AbsoluteSize.X>0 then
local M=L.AbsolutePosition.X if not J or M<J then J=M end end end if J then H=J-
u end else local J for K,L in ipairs(D:GetChildren())do if L:IsA'GuiObject'and L
.Visible and L.AbsoluteSize.X>0 then local M=L.AbsolutePosition.X+L.AbsoluteSize
.X if not J or M>J then J=M end end end if J then H=J+u end end elseif F then
local J=d.getRealXPositions(C,E)local K,L=J[F.UID],d.getWidth(F)H=(z and K-u)or
K+L+u end local J,K=0,false local function L()local M=d.getAvailableIcons
'Center'local N=(z and 1)or#M local O=M[N]if O and not O.hasRelocatedInOverflow
then local P,Q=(z and v[#v])or(A and v[1]),O.widget.AbsolutePosition.X local R,S
,T=P.widget.AbsolutePosition.X,d.getWidth(P),(z and Q-u)or Q+d.getWidth(O)+u
local U,V=(z and R+S)or R,false if Q==0 and R==0 then return end if z then if T<
U then O:align'Left'O.hasRelocatedInOverflow=true V=true end elseif A then if T>
U and U>=0 then O:align'Right'O.hasRelocatedInOverflow=true V=true end end if V
then J+=1 if J<=4 then d.updateAvailableIcons'Center'L()end end end end L()if B
then local M,N,O,P=H,B:getInstance'Menu',q+r,r if N and G then local Q=G.widget
local R,S=Q.AbsolutePosition.X,d.getWidth(G)local T,U=(z and R-u)or R+S+u,G:
getInstance'Menu'local V=N.AbsoluteCanvasSize.X>=U.AbsoluteCanvasSize.X if not K
then local W=q+r/2 local X=(z and W-u/2)or W+u/2 M=X if V then M=T end end P=(z
and M-q)or(O-M)end local Q=N and N:GetAttribute'MaxWidth'P=b.round(P)if N and Q
~=P then N:SetAttribute('MaxWidth',P)end end local M=false for N=#v,1,-1 do
local O=v[N]local P,Q=(d.getWidth(O))if I then Q=O.widget.AbsolutePosition.X
else local R=d.getRealXPositions(n,v)Q=R[O.UID]end if(z and Q+P>=H)or(A and Q<=H
)then M=true end end for N=#v,1,-1 do local O=v[N]local P=i[O.UID]if not P then
if M and not O.parentIconUID then O:joinMenu(B)elseif not M and O.parentIconUID
then O:leave()end end end if B.isEnabled~=M then B:setEnabled(M)end if B.
isEnabled and not B.overflowAlreadyOpened then B.overflowAlreadyOpened=true B:
select()end end return d end function a.h():typeof(b())local c=a.cache.h if not
c then c={c=b()}a.cache.h=c end return c.c end end do local b=function()return{}
end function a.i():typeof(b())local c=a.cache.i if not c then c={c=b()}a.cache.i
=c end return c.c end end do local b=function()return{{'Selection','Size',UDim2.
new(1,-6,1,-5)},{'Selection','Position',UDim2.new(0,3,0,3)},{'Widget',
'MinimumWidth',32,'Deselected'},{'Widget','MinimumHeight',32,'Deselected'},{
'Widget','BorderSize',0,'Deselected'},{'IconCorners','CornerRadius',UDim.new(0,9
),'Deselected'},{'IconButton','BackgroundTransparency',0.5,'Deselected'},{
'IconLabel','TextSize',14,'Deselected'},{'Dropdown','BackgroundTransparency',0.5
,'Deselected'},{'Notice','Position',UDim2.new(1,-12,0,-3),'Deselected'},{
'Notice','Size',UDim2.new(0,15,0,15),'Deselected'},{'NoticeLabel','TextSize',11,
'Deselected'},{'IconSpot','BackgroundColor3',Color3.fromRGB(0,0,0),'Selected'},{
'IconSpot','BackgroundTransparency',0.702,'Selected'},{'IconSpotGradient',
'Enabled',false,'Selected'},{'IconOverlay','BackgroundTransparency',0.97,
'Selected'}}end function a.j():typeof(b())local c=a.cache.j if not c then c={c=
b()}a.cache.j=c end return c.c end end do local b=function()local b,c=false,0
return function(d)local e,f,g,h,i=game:GetService'GuiService',game:GetService
'Players',game:GetService'UserInputService',{},a.a()local j,k,l,m,n,o,p,q=i.new(
),e:GetGuiInset(),0,0,0,0,false,false local function r(s)local t=e.TopbarInset.
Height local u=t<=36 p=e:IsTenFootInterface()q=g.VREnabled d.isOldTopbar=u o+=1
if t==0 and s==nil then task.defer(function()task.wait(8)r'ForceConvertToOld'end
)elseif o==1 then task.delay(5,function()if o==1 then r()end end)end if d.
isOldTopbar and not p and not q and b==false and(t~=0 or s=='ForceConvertToOld')
then b=true task.defer(function()local v=a.j()d.modifyBaseTheme(v)local w=
function()if e.MenuIsOpen then d.setTopbarEnabled(false,true)else d.
setTopbarEnabled()end end e:GetPropertyChangedSignal'MenuIsOpen':Connect(w)w()
end)end k=e:GetGuiInset()l=u and 12 or k.Y-50 m=u and 2 or 0 n=-2 if p then l=10
m=0 end if e.TopbarInset.Height==0 and not b then m+=13 n=50 end j:Fire(k)local
v=k.Y if v~=c then c=v task.defer(function()d.insetHeightChanged:Fire(v)end)end
end e:GetPropertyChangedSignal'TopbarInset':Connect(r)r'FirstTime'local s=
Instance.new'ScreenGui'j:Connect(function()s:SetAttribute('StartInset',l)end)s.
Name='TopbarStandard's.Enabled=true s.DisplayOrder=d.baseDisplayOrder s.
ZIndexBehavior=Enum.ZIndexBehavior.Sibling s.IgnoreGuiInset=true s.ResetOnSpawn=
false s.ScreenInsets=Enum.ScreenInsets.TopbarSafeInsets h[s.Name]=s d.
baseDisplayOrderChanged:Connect(function()s.DisplayOrder=d.baseDisplayOrder end)
local t=Instance.new'Frame't.Name='Holders't.BackgroundTransparency=1 j:Connect(
function()local u=q and 36 or 56 local v=(p and{(UDim2.new(1,0,0,u))}or{(UDim2.
new(1,0,1,n))})[1]t.Position=UDim2.new(0,0,0,m)t.Size=v end)t.Visible=true t.
ZIndex=1 t.Parent=s local u=s:Clone()local v=u.Holders local w=function()v.Size=
UDim2.new(1,0,0,e.TopbarInset.Height+n)end u.Name='TopbarCentered'u.DisplayOrder
=d.baseDisplayOrder u.ScreenInsets=Enum.ScreenInsets.None d.
baseDisplayOrderChanged:Connect(function()u.DisplayOrder=d.baseDisplayOrder end)
h[u.Name]=u j:Connect(w)w()local x=s:Clone()x.Name=x.Name..'Clipped'x.
DisplayOrder=(d.baseDisplayOrder+1)d.baseDisplayOrderChanged:Connect(function()x
.DisplayOrder=(d.baseDisplayOrder+1)end)h[x.Name]=x local y=u:Clone()y.Name=y.
Name..'Clipped'y.DisplayOrder=(d.baseDisplayOrder+1)d.baseDisplayOrderChanged:
Connect(function()y.DisplayOrder=(d.baseDisplayOrder+1)end)h[y.Name]=y local z,A
=-24,Instance.new'ScrollingFrame'A:SetAttribute('IsAHolder',true)A.Name='Left'j:
Connect(function()A.Position=UDim2.fromOffset(l,0)end)A.Size=UDim2.new(1,z,1,0)A
.BackgroundTransparency=1 A.Visible=true A.ZIndex=1 A.Active=false A.
ClipsDescendants=true A.HorizontalScrollBarInset=Enum.ScrollBarInset.None A.
CanvasSize=UDim2.new(0,0,1,-1)A.AutomaticCanvasSize=Enum.AutomaticSize.X A.
ScrollingDirection=Enum.ScrollingDirection.X A.ScrollBarThickness=0 A.
BorderSizePixel=0 A.Selectable=false A.ScrollingEnabled=false A.ElasticBehavior=
Enum.ElasticBehavior.Never A.Parent=t local B=Instance.new'UIListLayout'j:
Connect(function()B.Padding=UDim.new(0,l)end)B.FillDirection=Enum.FillDirection.
Horizontal B.SortOrder=Enum.SortOrder.LayoutOrder B.VerticalAlignment=Enum.
VerticalAlignment.Bottom B.HorizontalAlignment=Enum.HorizontalAlignment.Left B.
Parent=A local C=A:Clone()j:Connect(function()C.UIListLayout.Padding=UDim.new(0,
l)end)C.ScrollingEnabled=false C.UIListLayout.HorizontalAlignment=Enum.
HorizontalAlignment.Center C.Name='Center'C.Parent=v local D=A:Clone()j:Connect(
function()D.UIListLayout.Padding=UDim.new(0,l)end)D.UIListLayout.
HorizontalAlignment=Enum.HorizontalAlignment.Right D.Name='Right'D.AnchorPoint=
Vector2.new(1,0)D.Position=UDim2.new(1,-12,0,0)D.Parent=t j:Fire(k)return h end
end function a.k():typeof(b())local c=a.cache.k if not c then c={c=b()}a.cache.k
=c end return c.c end end do local b=function()return{}end function a.l():
typeof(b())local c=a.cache.l if not c then c={c=b()}a.cache.l=c end return c.c
end end do local b=function()return function(b)local c=Instance.new
'ScrollingFrame'c.Name='Menu'c.BackgroundTransparency=1 c.Visible=true c.ZIndex=
1 c.Size=UDim2.fromScale(1,1)c.ClipsDescendants=true c.TopImage=''c.BottomImage=
''c.HorizontalScrollBarInset=Enum.ScrollBarInset.Always c.CanvasSize=UDim2.new(0
,0,1,-1)c.ScrollingEnabled=true c.ScrollingDirection=Enum.ScrollingDirection.X c
.ZIndex=20 c.ScrollBarThickness=3 c.ScrollBarImageColor3=Color3.fromRGB(255,255,
255)c.ScrollBarImageTransparency=0.8 c.BorderSizePixel=0 c.Selectable=false
local d,e=(b._iconRef)do local f=d.topbarHoldersOverride local g=f and(f.Left or
f.Center or f.Right)e=g and g:FindFirstChildWhichIsA'UIListLayout'if not e then
e=d.container.TopbarStandard:FindFirstChild('UIListLayout',true)end end local f=
e:Clone()f.Name='MenuUIListLayout'f.VerticalAlignment=Enum.VerticalAlignment.
Center f.Parent=c local g=Instance.new'Frame'g.Name='MenuGap'g.
BackgroundTransparency=1 g.Visible=false g.AnchorPoint=Vector2.new(0,0.5)g.
ZIndex=5 g.Parent=c local h,i=false,a.e()local j=function()local j,k=b.
menuJanitor,#b.menuIcons if h then if k<=0 then j:Cleanup()h=false end return
end h=true j:add(b.toggled:Connect(function()if#b.menuIcons>0 then b.updateSize:
Fire()end end))local l,m=b:modifyTheme{{'Menu','Active',true}}task.defer(
function()j:add(function()b:removeModification(m)end)end)local n=c.
AbsoluteCanvasSize.X local o=function()if b.alignment=='Right'then local o=c.
AbsoluteCanvasSize.X local p=n-o n=o c.CanvasPosition=Vector2.new(c.
CanvasPosition.X-p,0)end end j:add(b.selected:Connect(o))j:add(c:
GetPropertyChangedSignal'AbsoluteCanvasSize':Connect(o))local p=b:getStateGroup(
)local q,r=i.getThemeValue(p,'IconImage','Image','Deselected'),i.getThemeValue(p
,'IconImage','Image','Selected')if q==r then local s=
'rbxasset://fonts/families/FredokaOne.json'local t=Font.new(s,Enum.FontWeight.
Light,Enum.FontStyle.Normal)b:removeModificationWith('IconLabel','Text',
'Viewing')b:removeModificationWith('IconLabel','Image','Viewing')b:modifyTheme{{
'IconLabel','FontFace',t,'Selected'},{'IconLabel','Text','X','Selected'},{
'IconLabel','TextSize',20,'Selected'},{'IconLabel','TextStrokeTransparency',0.8,
'Selected'},{'IconImage','Image','','Selected'}}end local s=b:getInstance
'MenuGap'local t=function()local t,u,v=b.alignment,-99999,-99998 if t=='Right'
then u=99999 v=99998 end b:modifyTheme{'IconSpot','LayoutOrder',u}s.LayoutOrder=
v end j:add(b.alignmentChanged:Connect(t))t()c:GetAttributeChangedSignal
'MenuCanvasWidth':Connect(function()local u,v=c:GetAttribute'MenuCanvasWidth',c.
CanvasSize.Y c.CanvasSize=UDim2.new(0,u,v.Scale,v.Offset)end)j:add(b.updateMenu:
Connect(function()local u=c:GetAttribute'MaxIcons'if not u then return end local
v={}for w,x in pairs(c:GetChildren())do local y=x:GetAttribute'WidgetUID'if y
and x.Visible then table.insert(v,{x,x.AbsolutePosition.X})end end table.sort(v,
function(w,x)return w[2]<x[2]end)local w=0 for x=1,u do local y=v[x]if not y
then break end local z=y[1]local A=z.AbsoluteSize.X+f.Padding.Offset w+=A end c:
SetAttribute('MenuWidth',w)end))local u=function()task.delay(0.1,function()b.
startMenuUpdate:Fire()end)end j:add(c.ChildAdded:Connect(u))j:add(c.ChildRemoved
:Connect(u))j:add(c:GetAttributeChangedSignal'MaxIcons':Connect(u))j:add(c:
GetAttributeChangedSignal'MaxWidth':Connect(u))u()end b.menuChildAdded:Connect(j
)b.menuSet:Connect(function(k)for l,m in pairs(b.menuIcons)do local n=d.
getIconByUID(m)n:destroy()end if type(k)=='table'then for l,m in pairs(k)do m:
joinMenu(b)end end end)return c end end function a.m():typeof(b())local c=a.
cache.m if not c then c={c=b()}a.cache.m=c end return c.c end end do local aa=
function()return function(b,c)local d=Instance.new'Frame'd:SetAttribute(
'WidgetUID',b.UID)d.Name='Widget'd.BackgroundTransparency=1 d.Visible=true d.
ZIndex=20 d.Active=false d.ClipsDescendants=true local e=Instance.new'Frame'e.
Name='IconButton'e.Visible=true e.ZIndex=2 e.BorderSizePixel=0 e.Parent=d e.
ClipsDescendants=true e.Active=false b.deselected:Connect(function()e.
ClipsDescendants=true task.delay(0.2,function()if b.isSelected then e.
ClipsDescendants=false end end)end)local f=game:GetService'GuiService'b:
setBehaviour('IconButton','BackgroundTransparency',function(g)local h=f.
PreferredTransparency local i=g*h if g==1 then return g end return i end)b.
janitor:add(f:GetPropertyChangedSignal'PreferredTransparency':Connect(function()
b:refreshAppearance(e,'BackgroundTransparency')end))local g=Instance.new
'UICorner'g:SetAttribute('Collective','IconCorners')g.Name='UICorner'g.Parent=e
local h=a.m()(b)local i,j=h.MenuUIListLayout,h.MenuGap h.Parent=e local k=
Instance.new'Frame'k.Name='IconSpot'k.BackgroundColor3=Color3.fromRGB(225,225,
225)k.BackgroundTransparency=0.9 k.Visible=true k.AnchorPoint=Vector2.new(0,0.5)
k.ZIndex=5 k.Parent=h local l=g:Clone()l.Parent=k local m=k:Clone()m.UICorner.
Name='OverlayUICorner'm.Name='IconOverlay'm.BackgroundColor3=Color3.fromRGB(255,
255,255)m.ZIndex=k.ZIndex+1 m.Size=UDim2.new(1,0,1,0)m.Position=UDim2.new(0,0,0,
0)m.AnchorPoint=Vector2.new(0,0)m.Visible=false m.Parent=k local n=Instance.new
'TextButton'n:SetAttribute('CorrespondingIconUID',b.UID)n.Name='ClickRegion'n.
BackgroundTransparency=1 n.Visible=true n.Text=''n.ZIndex=20 n.Selectable=true n
.SelectionGroup=true n.Parent=k local o=a.g()o.registerButton(n)local p=g:Clone(
)p.Parent=n local q=Instance.new'Frame'q.Name='Contents'q.BackgroundTransparency
=1 q.Size=UDim2.fromScale(1,1)q.Parent=k local r=Instance.new'UIListLayout'r.
Name='ContentsList'r.FillDirection=Enum.FillDirection.Horizontal r.
VerticalAlignment=Enum.VerticalAlignment.Center r.SortOrder=Enum.SortOrder.
LayoutOrder r.VerticalFlex=Enum.UIFlexAlignment.SpaceEvenly r.Padding=UDim.new(0
,3)r.Parent=q local s=Instance.new'Frame's.Name='PaddingLeft's.LayoutOrder=1 s.
ZIndex=5 s.BorderColor3=Color3.fromRGB(0,0,0)s.BackgroundTransparency=1 s.
BorderSizePixel=0 s.BackgroundColor3=Color3.fromRGB(255,255,255)s.Parent=q local
t=Instance.new'Frame't.Name='PaddingCenter't.LayoutOrder=3 t.ZIndex=5 t.Size=
UDim2.new(0,0,1,0)t.BorderColor3=Color3.fromRGB(0,0,0)t.BackgroundTransparency=1
t.BorderSizePixel=0 t.BackgroundColor3=Color3.fromRGB(255,255,255)t.Parent=q
local u=Instance.new'Frame'u.Name='PaddingRight'u.LayoutOrder=5 u.ZIndex=5 u.
BorderColor3=Color3.fromRGB(0,0,0)u.BackgroundTransparency=1 u.BorderSizePixel=0
u.BackgroundColor3=Color3.fromRGB(255,255,255)u.Parent=q local v=Instance.new
'Frame'v.Name='IconLabelContainer'v.LayoutOrder=4 v.ZIndex=3 v.AnchorPoint=
Vector2.new(0,0.5)v.Size=UDim2.new(0,0,0.5,0)v.BackgroundTransparency=1 v.
Position=UDim2.new(0.5,0,0.5,0)v.Parent=q local w,x=Instance.new'TextLabel',
workspace.CurrentCamera.ViewportSize.X+200 w.Name='IconLabel'w.LayoutOrder=4 w.
ZIndex=15 w.AnchorPoint=Vector2.new(0,0)w.Size=UDim2.new(0,x,1,0)w.
ClipsDescendants=false w.BackgroundTransparency=1 w.Position=UDim2.fromScale(0,0
)w.RichText=true w.TextColor3=Color3.fromRGB(255,255,255)w.TextXAlignment=Enum.
TextXAlignment.Left w.Text=''w.TextWrapped=true w.TextWrap=true w.TextScaled=
false w.Active=false w.AutoLocalize=true w.Parent=v local y=Instance.new
'ImageLabel'y.Name='IconImage'y.LayoutOrder=2 y.ZIndex=15 y.AnchorPoint=Vector2.
new(0,0.5)y.Size=UDim2.new(0,0,0.5,0)y.BackgroundTransparency=1 y.Position=UDim2
.new(0,11,0.5,0)y.ScaleType=Enum.ScaleType.Stretch y.Active=false y.Parent=q
local z=g:Clone()z:SetAttribute('Collective',nil)z.CornerRadius=UDim.new(0,0)z.
Name='IconImageCorner'z.Parent=y local A,B=game:GetService'TweenService',0 local
aa,ab=function(C)task.defer(function()local D=b.indicator local E=D and D.
Visible local F,G,H,I=E or w.Text~='',y.Image~=''and y.Image~=nil,Enum.
HorizontalAlignment.Center,UDim2.fromScale(1,1)local J=I if G and not F then v.
Visible=false y.Visible=true s.Visible=false t.Visible=false u.Visible=false
elseif not G and F then v.Visible=true y.Visible=false s.Visible=true t.Visible=
false u.Visible=true elseif G and F then v.Visible=true y.Visible=true s.Visible
=true t.Visible=not E u.Visible=not E H=Enum.HorizontalAlignment.Left end e.Size
=J local K,L=function(K)local L=K:GetAttribute'TargetWidth'or K.AbsoluteSize.X
return L end,r.Padding.Offset local M,N=L,w.TextBounds.X v.Size=UDim2.new(0,N,w.
Size.Y.Scale,0)for O,P in pairs(q:GetChildren())do if P:IsA'GuiObject'and P.
Visible==true then local Q=K(P)M+=Q+L end end local O,P,Q=d:GetAttribute
'MinimumWidth'or 0,d:GetAttribute'MinimumHeight'or 0,d:GetAttribute'BorderSize'
or 0 local R,S,T=math.clamp(M,O,x),b.menuIcons,0 local U=#S>0 local V=U and b.
isSelected if V then for W,X in pairs(h:GetChildren())do if X~=k and X:IsA
'GuiObject'and X.Visible then T+=K(X)+i.Padding.Offset end end if not k.Visible
then R-=(K(k)+i.Padding.Offset*2+Q)end T-=(Q*0.5)R+=T-(Q*0.75)end j.Visible=V
and k.Visible local W=d:GetAttribute'DesiredWidth'if W and R<W then R=W end b.
updateMenu:Fire()local X=math.max(R-T,O)local Y,Z=X-(Q*2),h:GetAttribute
'MenuWidth'local _=Z and Z+Y+i.Padding.Offset+10 if _ then local aa=h:
GetAttribute'MaxWidth'if aa then _=math.max(aa,O)end h:SetAttribute(
'MenuCanvasWidth',R)if _<R then R=_ end end local aa,ab,ac,ad,ae=Enum.
EasingStyle.Quint,Enum.EasingDirection.Out,math.max(Y,K(k),k.AbsoluteSize.X),
math.max(R,K(d),d.AbsoluteSize.X),750 local af,ag=TweenInfo.new(ac/ae,aa,ab),
TweenInfo.new(ad/ae,aa,ab)A:Create(k,af,{Position=UDim2.new(0,Q,0.5,0),Size=
UDim2.new(0,Y,1,-Q*2)}):Play()A:Create(n,af,{Size=UDim2.new(0,Y,1,0)}):Play()
local ah,ai=UDim2.fromOffset(R,P),d.Size.Y.Offset~=P if ai then d.Size=ah end d:
SetAttribute('TargetWidth',ah.X.Offset)local aj=A:Create(d,ag,{Size=ah})aj:Play(
)B+=1 for ak=1,ag.Time*100 do task.delay(ak/100,function()c.iconChanged:Fire(b)
end)end task.delay(ag.Time-0.2,function()B-=1 task.defer(function()if B==0 then
b.resizingComplete:Fire()end end)end)b:updateParent()end)end,a.c()local ac,ad=ab
.createStagger(0.01,aa),true b:setBehaviour('IconLabel','Text',ac)b:
setBehaviour('IconLabel','FontFace',function(ae)local af=w.FontFace if af==ae
then return end task.spawn(function()ac()if ad then ad=false for ag=1,10 do task
.wait(1)ac()end end end)end)local ae=function()task.defer(function()local ae,af=
d:GetAttribute'BorderSize'or 0,b.alignment local ag=(k.Visible==false and 0)or(
af=='Right'and-ae)or ae h.Position=UDim2.new(0,ag,0,0)j.Size=UDim2.fromOffset(ae
,0)i.Padding=UDim.new(0,0)ac()end)end b:setBehaviour('Widget','BorderSize',ae)b:
setBehaviour('IconSpot','Visible',ae)b.startMenuUpdate:Connect(ac)b.updateSize:
Connect(ac)b:setBehaviour('ContentsList','HorizontalAlignment',ac)b:
setBehaviour('Widget','Visible',ac)b:setBehaviour('Widget','DesiredWidth',ac)b:
setBehaviour('Widget','MinimumWidth',ac)b:setBehaviour('Widget','MinimumHeight',
ac)b:setBehaviour('Indicator','Visible',ac)b:setBehaviour('IconImageRatio',
'AspectRatio',ac)b:setBehaviour('IconImage','Image',function(af)local ag=(
tonumber(af)and'http://www.roblox.com/asset/?id='..af)or af or''if y.Image~=ag
then ac()end return ag end)b.alignmentChanged:Connect(function(af)if af==
'Center'then af='Left'end i.HorizontalAlignment=Enum.HorizontalAlignment[af]ae()
end)local af=game:GetService'Players'local ag=af.LocalPlayer local ah=ag.
LocaleId b.janitor:add(ag:GetPropertyChangedSignal'LocaleId':Connect(function()
task.delay(0.2,function()local ai=ag.LocaleId if ai~=ah then ah=ai b:refresh()
task.wait(0.5)b:refresh()end end)end))local ai=Instance.new'NumberValue'ai.Name=
'IconImageScale'ai.Parent=y ai:GetPropertyChangedSignal'Value':Connect(function(
)y.Size=UDim2.new(ai.Value,0,ai.Value,0)end)local aj=Instance.new
'UIAspectRatioConstraint'aj.Name='IconImageRatio'aj.AspectType=Enum.AspectType.
FitWithinMaxSize aj.DominantAxis=Enum.DominantAxis.Height aj.Parent=y local ak=
Instance.new'UIGradient'ak.Name='IconGradient'ak.Enabled=true ak.Parent=e local
C=Instance.new'UIGradient'C.Name='IconSpotGradient'C.Enabled=true C.Parent=k
return d end end function a.n():typeof(aa())local ab=a.cache.n if not ab then ab
={c=aa()}a.cache.n=ab end return ab.c end end do local aa=function()return
function(aa,ab)local ac=Instance.new'Frame'ac.Name='Notice'ac.ZIndex=25 ac.
AutomaticSize=Enum.AutomaticSize.X ac.BorderColor3=Color3.fromRGB(0,0,0)ac.
BorderSizePixel=0 ac.BackgroundTransparency=0.1 ac.BackgroundColor3=Color3.
fromRGB(255,255,255)ac.Visible=false ac.Parent=aa.widget local ad=Instance.new
'UICorner'ad.CornerRadius=UDim.new(1,0)ad.Parent=ac local ae=Instance.new
'UIStroke'ae.Parent=ac local af=Instance.new'TextLabel'af.Name='NoticeLabel'af.
ZIndex=26 af.AnchorPoint=Vector2.new(0.5,0.5)af.AutomaticSize=Enum.AutomaticSize
.X af.Size=UDim2.new(1,0,1,0)af.BackgroundTransparency=1 af.Position=UDim2.new(
0.5,0,0.515,0)af.BackgroundColor3=Color3.fromRGB(0,0,0)af.FontSize=Enum.FontSize
.Size14 af.TextColor3=Color3.fromRGB(0,0,0)af.Text='1'af.TextWrapped=true af.
TextWrap=true af.Font=Enum.Font.Arial af.Parent=ac local ag,ah,ai=a.b(),a.a(),a.
c()aa.noticeChanged:Connect(function(aj)if not aj then return end local ak=aj>99
local b=(ak and'99+')or aj af.Text=b if ak then af.TextSize=11 end local c=true
if aj<1 then c=false end local d,e=ab.getIconByUID(aa.parentIconUID),#aa.
dropdownIcons>0 or#aa.menuIcons>0 if aa.isSelected and e then c=false elseif d
and not d.isSelected then c=false end ai.setVisible(ac,c,'NoticeHandler')end)aa.
noticeStarted:Connect(function(aj,ak)if not aj then aj=aa.deselected end local b
=ab.getIconByUID(aa.parentIconUID)if b then b:notify(aj)end local c=aa.janitor:
add(ag.new())local d=c:add(ah.new())c:add(aa.endNotices:Connect(function()d:
Fire()end))c:add(aj:Connect(function()d:Fire()end))ak=ak or ai.generateUID()aa.
notices[ak]={completeSignal=d,clearNoticeEvent=aj}local e=function()aa.
noticeChanged:Fire(aa.totalNotices)end aa.notified:Fire(ak)aa.totalNotices+=1 e(
)d:Once(function()c:destroy()aa.totalNotices-=1 aa.notices[ak]=nil e()end)end)ac
:SetAttribute('ClipToJoinedParent',true)aa:clipOutside(ac)return ac end end
function a.o():typeof(aa())local ab=a.cache.o if not ab then ab={c=aa()}a.cache.
o=ab end return ab.c end end do local aa=function()local aa,ab=Color3.fromRGB(39
,41,48),15 return function(ac)local ad,ae=ac:getInstance'ClickRegion',Instance.
new'CanvasGroup'ae.Name='Caption'ae.AnchorPoint=Vector2.new(0.5,0)ae.
BackgroundTransparency=1 ae.BorderSizePixel=0 ae.GroupTransparency=1 ae.Position
=UDim2.fromOffset(0,0)ae.Visible=true ae.ZIndex=30 ae.Parent=ad local af=
Instance.new'Frame'af.Name='Box'af.AutomaticSize=Enum.AutomaticSize.XY af.
BackgroundColor3=aa af.Position=UDim2.fromOffset(4,7)af.ZIndex=12 af.Parent=ae
local ag=Instance.new'TextLabel'ag.Name='Header'ag.FontFace=Font.new(
'rbxasset://fonts/families/BuilderSans.json',Enum.FontWeight.Medium,Enum.
FontStyle.Normal)ag.Text='Caption'ag.TextColor3=Color3.fromRGB(255,255,255)ag.
TextSize=ab ag.TextTruncate=Enum.TextTruncate.None ag.TextWrapped=false ag.
TextXAlignment=Enum.TextXAlignment.Left ag.AutomaticSize=Enum.AutomaticSize.X ag
.BackgroundTransparency=1 ag.LayoutOrder=1 ag.Size=UDim2.fromOffset(0,16)ag.
ZIndex=18 ag.Parent=af local ah=Instance.new'UIListLayout'ah.Name='Layout'ah.
Padding=UDim.new(0,8)ah.SortOrder=Enum.SortOrder.LayoutOrder ah.Parent=af local
ai=Instance.new'UICorner'ai.Name='CaptionCorner'ai.Parent=af local aj=Instance.
new'UIPadding'aj.Name='Padding'aj.PaddingBottom=UDim.new(0,12)aj.PaddingLeft=
UDim.new(0,12)aj.PaddingRight=UDim.new(0,12)aj.PaddingTop=UDim.new(0,12)aj.
Parent=af local ak=Instance.new'Frame'ak.Name='Hotkeys'ak.AutomaticSize=Enum.
AutomaticSize.Y ak.BackgroundTransparency=1 ak.LayoutOrder=3 ak.Size=UDim2.
fromScale(1,0)ak.Visible=false ak.Parent=af local b=Instance.new'UIListLayout'b.
Name='Layout1'b.Padding=UDim.new(0,6)b.FillDirection=Enum.FillDirection.Vertical
b.HorizontalAlignment=Enum.HorizontalAlignment.Center b.HorizontalFlex=Enum.
UIFlexAlignment.None b.ItemLineAlignment=Enum.ItemLineAlignment.Automatic b.
VerticalFlex=Enum.UIFlexAlignment.None b.SortOrder=Enum.SortOrder.LayoutOrder b.
Parent=ak local c=Instance.new'ImageLabel'c.Name='Key1'c.Image=
'rbxasset://textures/ui/Controls/key_single.png'c.ImageTransparency=0.7 c.
ScaleType=Enum.ScaleType.Slice c.SliceCenter=Rect.new(5,5,23,24)c.AutomaticSize=
Enum.AutomaticSize.X c.BackgroundTransparency=1 c.LayoutOrder=1 c.Size=UDim2.
fromOffset(0,30)c.ZIndex=15 c.Parent=ak local d=Instance.new'UIPadding'd.Name=
'Inset'd.PaddingLeft=UDim.new(0,8)d.PaddingRight=UDim.new(0,8)d.Parent=c local e
=Instance.new'TextLabel'e.AutoLocalize=false e.Name='LabelContent'e.FontFace=
Font.new('rbxasset://fonts/families/GothamSSm.json',Enum.FontWeight.Medium,Enum.
FontStyle.Normal)e.Text=''e.TextColor3=Color3.fromRGB(189,190,190)e.TextSize=ab
e.AutomaticSize=Enum.AutomaticSize.X e.BackgroundTransparency=1 e.Position=UDim2
.fromOffset(0,-1)e.Size=UDim2.fromScale(1,1)e.ZIndex=16 e.Parent=c local f=
Instance.new'ImageLabel'f.Name='Caret'f.Image='rbxassetid://101906294438076'f.
ImageColor3=aa f.AnchorPoint=Vector2.new(0,0.5)f.BackgroundTransparency=1 f.
Position=UDim2.new(0,0,0,4)f.Size=UDim2.fromOffset(16,8)f.ZIndex=12 f.Parent=ae
local g=Instance.new'ImageLabel'g.Visible=true g.Name='DropShadow'g.Image=
'rbxassetid://124920646932671'g.ImageColor3=Color3.fromRGB(0,0,0)g.
ImageTransparency=0.45 g.ScaleType=Enum.ScaleType.Slice g.SliceCenter=Rect.new(
12,12,13,13)g.BackgroundTransparency=1 g.Position=UDim2.fromOffset(0,5)g.Size=
UDim2.new(1,0,0,48)g.Parent=ae af:GetPropertyChangedSignal'AbsoluteSize':
Connect(function()g.Size=UDim2.new(1,0,0,af.AbsoluteSize.Y+8)end)local h,i,j=ac.
captionJanitor,ac:clipOutside(ae)j.AutomaticSize=Enum.AutomaticSize.None local k
=function()local k=ae.AbsoluteSize j.Size=UDim2.fromOffset(k.X,k.Y)end h:add(ae:
GetPropertyChangedSignal'AbsoluteSize':Connect(k))k()local l,m,n=false,ae.Box.
Header,game:GetService'UserInputService'local o=function(o)local p,q=n.
KeyboardEnabled,ae:GetAttribute'CaptionText'or''local r=q=='_hotkey_'if not p
and r then ac:setCaption()return end m.Text=q m.Visible=not r if o then e.Text=o
.Name ak.Visible=true end if not p then ak.Visible=false end end ae:
GetAttributeChangedSignal'CaptionText':Connect(o)local p,q=Enum.EasingStyle.Quad
,0.2 local r,s,t,u,v=TweenInfo.new(q,p,Enum.EasingDirection.In),TweenInfo.new(q,
p,Enum.EasingDirection.Out),game:GetService'TweenService',game:GetService
'RunService',function(r)local s,t=(r~=nil and{r}or{l})[1],2 local u=t+8 local v=
(s and{u}or{t})[1]return UDim2.new(0.5,0,1,v)end local w=function(w)if not l
then return end local x=(w~=nil and{w}or{l})[1]local y,z=v(not x),v(x)if x then
local A=f.Position.Y.Offset f.Position=UDim2.fromOffset(0,A)ae.AutomaticSize=
Enum.AutomaticSize.XY ae.Size=UDim2.fromOffset(32,53)else local A=ae.
AbsoluteSize ae.AutomaticSize=Enum.AutomaticSize.Y ae.Size=UDim2.fromOffset(A.X,
A.Y)end local A local B=function()local B,C=ad.AbsolutePosition.X-ae.
AbsolutePosition.X+ad.AbsoluteSize.X/2-f.AbsoluteSize.X/2,f.Position.Y.Offset
local D=UDim2.fromOffset(B,C)if A~=B then A=B f.Position=UDim2.fromOffset(0,C)
task.wait()end f.Position=D end j.Position=y B()local C=(x and r)or s local D,E=
t:Create(j,C,{Position=z}),u.Heartbeat:Connect(B)D:Play()D.Completed:Once(
function()E:Disconnect()end)end h:add(ad:GetPropertyChangedSignal'AbsoluteSize':
Connect(function()w()end))w(false)h:add(ac.toggleKeyAdded:Connect(o))for x,y in
pairs(ac.bindedToggleKeys)do o(x)break end h:add(ac.fakeToggleKeyChanged:
Connect(o))local x=ac.fakeToggleKey if x then o(x)end local y,z,A,B=function(y)
if l==y then return end local z=ac.joinedFrame if z and string.match(z.Name,
'Dropdown')then y=false end l=y local A,B=(y and 0)or 1,(y and r)or s local C=t:
Create(ae,B,{GroupTransparency=A})C:Play()if y then j:SetAttribute('ForceUpdate'
,true)end w()o()end,0.5,0.3,ac._iconRef h:add(ac.stateChanged:Connect(function(C
)if C=='Viewing'then local D=B.captionLastClosedClock local E=(D and os.clock()-
D)or 999 local F=(E<A and 0)or z task.delay(F,function()if ac.activeState==
'Viewing'then y(true)end end)else B.captionLastClosedClock=os.clock()y(false)end
end))return ae end end function a.p():typeof(aa())local ab=a.cache.p if not ab
then ab={c=aa()}a.cache.p=ab end return ab.c end end do local aa=function()local
aa,ab,ac,ad=game:GetService'TweenService',game:GetService'RunService',a.e(),0
return function(ae)local af=Instance.new'Frame'af.Name='Dropdown'af.
AutomaticSize=Enum.AutomaticSize.X af.BackgroundTransparency=1 af.
BorderSizePixel=0 af.AnchorPoint=Vector2.new(0.5,0)af.Position=UDim2.new(0.5,0,1
,10)af.ZIndex=-2 af.ClipsDescendants=true af.Parent=ae.widget local ag=game:
GetService'GuiService'ae:setBehaviour('Dropdown','BackgroundTransparency',
function(ah)local ai=ag.PreferredTransparency local aj=ah*ai if ah==1 then
return ah end return aj end)ae.janitor:add(ag:GetPropertyChangedSignal
'PreferredTransparency':Connect(function()ae:refreshAppearance(af,
'BackgroundTransparency')end))local ah=Instance.new'UICorner'ah.Name=
'DropdownCorner'ah.CornerRadius=UDim.new(0,10)ah.Parent=af local ai=Instance.new
'ScrollingFrame'ai.Name='DropdownScroller'ai.AutomaticSize=Enum.AutomaticSize.X
ai.BackgroundTransparency=1 ai.BorderSizePixel=0 ai.AnchorPoint=Vector2.new(0,0)
ai.Position=UDim2.new(0,0,0,0)ai.ZIndex=-1 ai.ClipsDescendants=true ai.Visible=
true ai.VerticalScrollBarInset=Enum.ScrollBarInset.None ai.
VerticalScrollBarPosition=Enum.VerticalScrollBarPosition.Right ai.Active=false
ai.ScrollingEnabled=true ai.AutomaticCanvasSize=Enum.AutomaticSize.Y ai.
ScrollBarThickness=5 ai.ScrollBarImageColor3=Color3.fromRGB(255,255,255)ai.
ScrollBarImageTransparency=0.8 ai.CanvasSize=UDim2.new(0,0,0,0)ai.Selectable=
false ai.Active=true ai.Parent=af local aj=Instance.new'NumberValue'aj.Name=
'DropdownSpeed'aj.Value=0.07 aj.Parent=af local ak=Instance.new'UIPadding'ak.
Name='DropdownPadding'ak.PaddingTop=UDim.new(0,ad)ak.PaddingBottom=UDim.new(0,ad
)ak.Parent=ai local b=Instance.new'UIListLayout'b.Name='DropdownList'b.
FillDirection=Enum.FillDirection.Vertical b.SortOrder=Enum.SortOrder.LayoutOrder
b.HorizontalAlignment=Enum.HorizontalAlignment.Center b.HorizontalFlex=Enum.
UIFlexAlignment.SpaceEvenly b.Parent=ai local c,d=ae.dropdownJanitor,ae._iconRef
ae.dropdownChildAdded:Connect(function(e)local f,g=e:modifyTheme{{'Widget',
'BorderSize',0},{'IconCorners','CornerRadius',UDim.new(0,10)},{'Widget',
'MinimumWidth',190},{'Widget','MinimumHeight',58},{'IconLabel','TextSize',20},{
'IconOverlay','Size',UDim2.new(1,0,1,0)},{'PaddingLeft','Size',UDim2.fromOffset(
25,0)},{'Notice','Position',UDim2.new(1,-24,0,5)},{'ContentsList',
'HorizontalAlignment',Enum.HorizontalAlignment.Left},{'Selection','Size',UDim2.
new(1,-ad,1,-ad)},{'Selection','Position',UDim2.new(0,ad/2,0,ad/2)}}task.defer(
function()e.joinJanitor:add(function()e:removeModification(g)end)end)end)ae.
dropdownSet:Connect(function(e)for f,g in pairs(ae.dropdownIcons)do local h=d.
getIconByUID(g)h:destroy()end if type(e)=='table'then for f,g in pairs(e)do g:
joinDropdown(ae)end end end)local e,f,g,h,i=function()local e=af:GetAttribute
'MaxIcons'if not e then return 0 end local f={}for g,h in pairs(ai:GetChildren()
)do if h:IsA'GuiObject'and h.Visible then table.insert(f,h)end end table.sort(f,
function(g,h)return g.AbsolutePosition.Y<h.AbsolutePosition.Y end)local g,h=0,
math.ceil(e)for i=1,h do local j=f[i]if not j then break end local k,l=j.
AbsoluteSize.Y,i==h and h~=e if l then k*=(e-h+1)end g+=k end g+=ak.PaddingTop.
Offset+ak.PaddingBottom.Offset return g end local j=function()local j=ac.
getInstanceValue(af,'MaxIcons')or 1 if h and h==j and i then return i end local
k=TweenInfo.new(aj.Value*j,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out
)i=k h=j return k end local k=function()local k=j()if f then f:Cancel()f=nil end
if g then g:Cancel()g=nil end if ae.isSelected then local l=e()af.Visible=true
af.BackgroundTransparency=0 af.Size=UDim2.new(0,af.Size.X.Offset,0,0)f=aa:
Create(af,k,{Size=UDim2.new(0,af.Size.X.Offset,0,l)})f:Play()f.Completed:
Connect(function()f=nil end)else local l=TweenInfo.new(0)g=aa:Create(af,l,{Size=
UDim2.new(0,af.Size.X.Offset,0,0)})g:Play()g.Completed:Connect(function()g=nil
end)end end c:add(ae.toggled:Connect(k))k()local l=function()local l=j()if not
ae.isSelected then return end if f then f:Cancel()f=nil end if g then g:Cancel()
g=nil end ab.Heartbeat:Wait()local m=e()f=aa:Create(af,l,{Size=UDim2.new(0,af.
Size.X.Offset,0,m)})f:Play()f.Completed:Connect(function()f=nil end)end c:add(ae
.toggled:Connect(k))local m,n=0,false local function o()m+=1 if n then return
end local p=m n=true task.defer(function()n=false if m~=p then o()end end)local
q=af:GetAttribute'MaxIcons'if not q then return end local r={}for s,t in pairs(
ai:GetChildren())do if t:IsA'GuiObject'and t.Visible then table.insert(r,{t,t.
AbsolutePosition.Y})end end table.sort(r,function(s,t)return s[2]<t[2]end)local
s,t,u=0,false,math.ceil(q)for v=1,u do local w=r[v]if not w then break end local
x=w[1]local y,z=x.AbsoluteSize.Y,v==u and u~=q if z then y=y*(q-u+1)end s+=y if
z then continue end local A=x:GetAttribute'WidgetUID'local B=A and d.
getIconByUID(A)if B then local C if not t then t=true C=ae:getInstance
'ClickRegion'end B:getInstance'ClickRegion'.NextSelectionUp=C end end s+=ak.
PaddingTop.Offset+ak.PaddingBottom.Offset ai.Size=UDim2.fromOffset(0,s)end c:
add(ai:GetPropertyChangedSignal'AbsoluteCanvasSize':Connect(o))c:add(ai.
ChildAdded:Connect(o))c:add(ai.ChildRemoved:Connect(l))c:add(ai.ChildRemoved:
Connect(o))c:add(af:GetAttributeChangedSignal'MaxIcons':Connect(o))c:add(af:
GetAttributeChangedSignal'MaxIcons':Connect(l))c:add(ae.childThemeModified:
Connect(o))o()local p=function(p)if p:IsA'GuiObject'then p:
GetPropertyChangedSignal'Visible':Connect(l)p:GetPropertyChangedSignal'Size':
Connect(l)end end for q,r in pairs(ai:GetChildren())do p(r)end ai.ChildAdded:
Connect(function(q)ab.Heartbeat:Wait()p(q)l()end)af.Visible=false return af end
end function a.q():typeof(aa())local ab=a.cache.q if not ab then ab={c=aa()}a.
cache.q=ab end return ab.c end end do local aa=function()return function(aa,ab)
local ac,ad,ae=aa.widget,aa:getInstance'Contents',Instance.new'Frame'ae.Name=
'Indicator'ae.LayoutOrder=9999999 ae.ZIndex=6 ae.Size=UDim2.new(0,42,0,42)ae.
BorderColor3=Color3.fromRGB(0,0,0)ae.BackgroundTransparency=1 ae.Position=UDim2.
new(1,0,0.5,0)ae.BorderSizePixel=0 ae.BackgroundColor3=Color3.fromRGB(0,0,0)ae.
Parent=ad local af=Instance.new'Frame'af.Name='IndicatorButton'af.BorderColor3=
Color3.fromRGB(0,0,0)af.AnchorPoint=Vector2.new(0.5,0.5)af.BorderSizePixel=0 af.
BackgroundColor3=Color3.fromRGB(0,0,0)af.Parent=ae local ag,ah,ai=game:
GetService'GuiService',game:GetService'GamepadService',aa:getInstance
'ClickRegion'local aj=function()local aj=ag.SelectedObject if aj==ai then af.
BackgroundTransparency=1 af.Position=UDim2.new(0.5,-2,0.5,0)af.Size=UDim2.
fromScale(1.2,1.2)else af.BackgroundTransparency=0.75 af.Position=UDim2.new(0.5,
2,0.5,0)af.Size=UDim2.fromScale(1,1)end end aa.janitor:add(ag:
GetPropertyChangedSignal'SelectedObject':Connect(aj))aj()local ak=Instance.new
'ImageLabel'ak.LayoutOrder=2 ak.ZIndex=15 ak.AnchorPoint=Vector2.new(0.5,0.5)ak.
Size=UDim2.new(0.5,0,0.5,0)ak.BackgroundTransparency=1 ak.Position=UDim2.new(0.5
,0,0.5,0)ak.Image=
[[rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png]]ak.Parent=af
local b=Instance.new'UICorner'b.CornerRadius=UDim.new(1,0)b.Parent=af local c,d=
game:GetService'UserInputService',function(c)if c==nil then c=ae.Visible end if
ah.GamepadCursorEnabled then c=false end if c then aa:modifyTheme({
'PaddingRight','Size',UDim2.new(0,0,1,0)},'IndicatorPadding')elseif ae.Visible
then aa:removeModification'IndicatorPadding'end aa:modifyTheme{'Indicator',
'Visible',c}aa.updateSize:Fire()end aa.janitor:add(ah:GetPropertyChangedSignal
'GamepadCursorEnabled':Connect(d))aa.indicatorSet:Connect(function(e)local f=
false if e then ak.Image=c:GetImageForKeyCode(e)f=true end d(f)end)local e=
function()local e=ac.AbsoluteSize.Y*0.96 ae.Size=UDim2.new(0,e,0,e)end ac:
GetPropertyChangedSignal'AbsoluteSize':Connect(e)e()return ae end end function a
.r():typeof(aa())local ab=a.cache.r if not ab then ab={c=aa()}a.cache.r=ab end
return ab.c end end end local aa,ab,ac,ad,ae,af,ag=a.a(),a.b(),a.c(),a.e(),a.g()
,a.h(),{}ag.__index=ag local ah,ai,aj,ak=ac.Clone(game:GetService
'UserInputService'),ac.Clone(game:GetService'ContentProvider'),ac.Clone(game:
GetService'StarterGui'),a.i()export type Icon=Icon__DARKLUA_TYPE_l local b,c,d,e
={},aa.new(),0,{mobile=Enum.PreferredInput.Touch,desktop=Enum.PreferredInput.
KeyboardAndMouse,console=Enum.PreferredInput.Gamepad}ag.baseDisplayOrderChanged=
aa.new()ag.baseDisplayOrder=10 ag.baseTheme=a.d()ag.isOldTopbar=false ag.
iconsDictionary=b ag.insetHeightChanged=aa.new()ag.container=a.k()(ag)ag.
topbarHoldersOverride=nil ag.topbarPrimaryScreenGuiOverride=nil ag.topbarEnabled
=true ag.iconAdded=aa.new()ag.iconRemoved=aa.new()ag.iconChanged=aa.new()
function ag.getIcons()return ag.iconsDictionary end function ag.getIconByUID(f)
local g=ag.iconsDictionary[f]if g then return g end return nil end function ag.
getIcon(f)local g=ag.getIconByUID(f)if g then return g end for h,i in pairs(b)do
if i.name==f then return i end end return nil end function ag.setTopbarEnabled(f
,g)if typeof(f)~='boolean'then f=ag.topbarEnabled end if not g then ag.
topbarEnabled=f end for h,i in pairs(ag.container)do i.Enabled=f end end
function ag.modifyBaseTheme(f)f=ad.getModifications(f)for g,h in pairs(f)do for
i,j in pairs(ag.baseTheme)do ad.merge(j,h)end end for g,h in pairs(b)do h:
setTheme(ag.baseTheme)end end function ag.setDisplayOrder(f)ag.baseDisplayOrder=
f ag.baseDisplayOrderChanged:Fire(f)end task.defer(ae.start,ag)task.defer(af.
start,ag)task.defer(function()for f,g in pairs(ag.container)do ac.ProtectUI(g)
end a.l()end)function ag.new()local f={}setmetatable(f,ag)local g=ab.new()f.
janitor=g f.themesJanitor=g:add(ab.new())f.singleClickJanitor=g:add(ab.new())f.
captionJanitor=g:add(ab.new())f.joinJanitor=g:add(ab.new())f.menuJanitor=g:add(
ab.new())f.dropdownJanitor=g:add(ab.new())local h=ac.generateUID()b[h]=f g:add(
function()b[h]=nil end)f.selected=g:add(aa.new())f.deselected=g:add(aa.new())f.
toggled=g:add(aa.new())f.viewingStarted=g:add(aa.new())f.viewingEnded=g:add(aa.
new())f.stateChanged=g:add(aa.new())f.notified=g:add(aa.new())f.noticeStarted=g:
add(aa.new())f.noticeChanged=g:add(aa.new())f.endNotices=g:add(aa.new())f.
toggleKeyAdded=g:add(aa.new())f.fakeToggleKeyChanged=g:add(aa.new())f.
alignmentChanged=g:add(aa.new())f.updateSize=g:add(aa.new())f.resizingComplete=g
:add(aa.new())f.joinedParent=g:add(aa.new())f.menuSet=g:add(aa.new())f.
dropdownSet=g:add(aa.new())f.updateMenu=g:add(aa.new())f.startMenuUpdate=g:add(
aa.new())f.childThemeModified=g:add(aa.new())f.indicatorSet=g:add(aa.new())f.
dropdownChildAdded=g:add(aa.new())f.menuChildAdded=g:add(aa.new())f._iconRef=ag
f.UID=h f.isEnabled=true f.enabled=f.isEnabled f.isSelected=false f.isViewing=
false f.joinedFrame=false f.parentIconUID=false f.deselectWhenOtherIconSelected=
true f.totalNotices=0 f.activeState='Deselected'f.alignment=''f.
originalAlignment=''f.appliedTheme={}f.appearance={}f.cachedInstances={}f.
cachedNamesToInstances={}f.cachedCollectives={}f.bindedToggleKeys={}f.
customBehaviours={}f.toggleItems={}f.bindedEvents={}f.notices={}f.menuIcons={}f.
dropdownIcons={}f.childIconsDict={}f.creationTime=os.clock()local i=g:add(a.n()(
f,ag))f.widget=i f:setAlignment()d+=1 local j=1+(d*0.01)f:setOrder(j,
'deselected')f:setOrder(j,'selected')f:setTheme(ag.baseTheme)local k,l,m,n=f:
getInstance'ClickRegion',false,0,0.1 local o=function()if f.locked then return
end local o=tick()if o-m<n then return end m=o if f.isSelected then f:deselect(
'User',f)else f:select('User',f)end end k.MouseButton1Click:Connect(function()l=
true o()end)k.TouchTap:Connect(function()if not l then o()end end)g:add(ah.
InputBegan:Connect(function(p,q)if f.locked then return end if f.
bindedToggleKeys[p.KeyCode]and not q then o()end end))local p,q=function(p)if f.
locked then return end f.isViewing=true f.viewingStarted:Fire(true)if not p then
f:setState('Viewing','User',f)end end,function()if f.locked then return end f.
isViewing=false f.viewingEnded:Fire(true)f:setState(nil,'User',f)end f.
joinedParent:Connect(function()if f.isViewing then q()end end)k.MouseEnter:
Connect(function()local r=ah.PreferredInput~=e.desktop p(r)end)local r=0 g:add(
ah.TouchEnded:Connect(q))k.MouseLeave:Connect(q)k.SelectionGained:Connect(p)k.
SelectionLost:Connect(q)k.MouseButton1Down:Connect(function()if not f.locked and
ah.PreferredInput==e.mobile then r+=1 local s=r task.delay(0.2,function()if s==r
then p()end end)end end)k.MouseButton1Up:Connect(function()r+=1 end)local s=f:
getInstance'IconOverlay'f.viewingStarted:Connect(function()s.Visible=not f.
overlayDisabled end)f.viewingEnded:Connect(function()s.Visible=false end)g:add(c
:Connect(function(t)if t~=f and f.deselectWhenOtherIconSelected and t.
deselectWhenOtherIconSelected then f:deselect('AutoDeselect',t)end end))local t=
debug.info(2,'s')local u,v,w=string.split(t,'.'),game for x,y in pairs(u)do v=v:
FindFirstChild(y)if not v then break end if v:IsA'ScreenGui'then w=v end end if
v and w and w.ResetOnSpawn==true then f.originsScreenGui=w ac.
localPlayerRespawned(function()f:destroy()end)end f.toggled:Connect(function(x)f
.noticeChanged:Fire(f.totalNotices)for y,z in pairs(f.childIconsDict)do local A=
ag.getIconByUID(y)A.noticeChanged:Fire(A.totalNotices)if not x and A.isSelected
then for B,C in pairs(A.childIconsDict)do A:deselect('HideParentFeature',f)end
end end end)f.selected:Connect(function()local x=#f.dropdownIcons>0 if x then if
aj:GetCore'ChatActive'and f.alignment~='Right'then f.chatWasPreviouslyActive=
true aj:SetCore('ChatActive',false)end if aj:GetCoreGuiEnabled'PlayerList'and f.
alignment~='Left'then f.playerlistWasPreviouslyActive=true aj:SetCoreGuiEnabled(
Enum.CoreGuiType.PlayerList,false)end end end)f.deselected:Connect(function()if
f.chatWasPreviouslyActive then f.chatWasPreviouslyActive=nil aj:SetCore(
'ChatActive',true)end if f.playerlistWasPreviouslyActive then f.
playerlistWasPreviouslyActive=nil aj:SetCoreGuiEnabled(Enum.CoreGuiType.
PlayerList,true)end end)task.delay(0.1,function()if f.activeState=='Deselected'
then f.stateChanged:Fire'Deselected'f:refresh()end end)ag.iconAdded:Fire(f)
return f end function ag:setName(f)self.widget.Name=f self.name=f return self
end function ag:setState(f,g,h)if not f then f=(self.isSelected and'Selected')or
'Deselected'end local i,j=ac.formatStateName(f),self.activeState if j==i then
return end local k=self.isSelected self.activeState=i if i=='Deselected'then
self.isSelected=false if k then self.toggled:Fire(false,g,h)self.deselected:
Fire(g,h)end self:_setToggleItemsVisible(false,g,h)elseif i=='Selected'then self
.isSelected=true if not k then self.toggled:Fire(true,g,h)self.selected:Fire(g,h
)c:Fire(self,g,h)end self:_setToggleItemsVisible(true,g,h)end self.stateChanged:
Fire(i,g,h)end function ag:getInstance(f)local g=self.cachedNamesToInstances[f]
if g then return g end local h,i=function(h,i)local j=self.cachedInstances[i]if
not j then local k=i:GetAttribute'Collective'local l=k and self.
cachedCollectives[k]if l then table.insert(l,i)end self.cachedNamesToInstances[h
]=i self.cachedInstances[i]=true i.Destroying:Once(function()self.
cachedNamesToInstances[h]=nil self.cachedInstances[i]=nil end)end end,self.
widget h('Widget',i)if f=='Widget'then return i end local j local function k(l)
for m,n in pairs(l:GetChildren())do local o=n:GetAttribute'WidgetUID'if o and o
~=self.UID then continue end local p=ad.getRealInstance(n)if p then n=p end k(n)
if n:IsA'GuiBase'or n:IsA'UIBase'or n:IsA'ValueBase'then local q=n.Name h(q,n)if
q==f then j=n end end end end k(i)return j end function ag:getCollective(f)local
g=self.cachedCollectives[f]if g then return g end g={}for h,i in pairs(self.
cachedInstances)do if h:GetAttribute'Collective'==f then table.insert(g,h)end
end self.cachedCollectives[f]=g return g end function ag:getInstanceOrCollective
(f)local g,h={},self:getInstance(f)if h then table.insert(g,h)end if#g==0 then g
=self:getCollective(f)end return g end function ag:getStateGroup(f)local g=f or
self.activeState local h=self.appearance[g]if not h then h={}self.appearance[g]=
h end return h end function ag:refreshAppearance(f,g)ad.refresh(self,f,g)return
self end function ag:refresh()self:refreshAppearance(self.widget)self.updateSize
:Fire()return self end function ag:updateParent()local f=ag.getIconByUID(self.
parentIconUID)if f then f.updateSize:Fire()end end function ag:setBehaviour(f,g,
h,i)local j=f..'-'..g self.customBehaviours[j]=h if i then local k=self:
getInstanceOrCollective(f)for l,m in pairs(k)do self:refreshAppearance(m,g)end
end end function ag:modifyTheme(f,g)local h=ad.modify(self,f,g)return self,h end
function ag:modifyChildTheme(f,g)self.childModifications=f self.
childModificationsUID=g for h,i in pairs(self.childIconsDict)do local j=ag.
getIconByUID(h)j:modifyTheme(f,g)end self.childThemeModified:Fire()return self
end function ag:removeModification(f)ad.remove(self,f)return self end function
ag:removeModificationWith(f,g,h)ad.removeWith(self,f,g,h)return self end
function ag:setTheme(f)ad.set(self,f)return self end function ag:setEnabled(f)
self.isEnabled=f self.enabled=self.isEnabled self.widget.Visible=f self:
updateParent()return self end function ag:select(f,g)self:setState('Selected',f,
g)return self end function ag:deselect(f,g)self:setState('Deselected',f,g)return
self end function ag:notify(f,g)local h=self.notice if not h then h=a.o()(self,
ag)self.notice=h end self.noticeStarted:Fire(f,g)return self end function ag:
clearNotices()self.endNotices:Fire()return self end function ag:disableOverlay(f
)self.overlayDisabled=f return self end ag.disableStateOverlay=ag.disableOverlay
function ag:setImage(f,g)self:modifyTheme{'IconImage','Image',f,g}task.spawn(
function()local h=(tonumber(f)and{`rbxassetid://{f}`}or{f})[1]local i=ai:
GetAssetFetchStatus(h)if i~=Enum.AssetFetchStatus.Success then pcall(ai.
PreloadAsync,ai,{h})end end)return self end function ag:setLabel(f,g)self:
modifyTheme{'IconLabel','Text',f,g}return self end function ag:setOrder(f,g)
local h=f*100 self:modifyTheme{'IconSpot','LayoutOrder',h,g}self:modifyTheme{
'Widget','LayoutOrder',h,g}return self end function ag:setCornerRadius(f,g)self:
modifyTheme{'IconCorners','CornerRadius',f,g}return self end function ag:align(f
,g)local h=tostring(f):lower()if h=='mid'or h=='centre'then h='center'end if h~=
'left'and h~='center'and h~='right'then h='left'end local i,j,k,l=string.upper(
string.sub(h,1,1))..string.sub(h,2),(ag.topbarHoldersOverride)if j and j[i]then
k=j[i]l=k:FindFirstAncestorWhichIsA'ScreenGui'or ag.
topbarPrimaryScreenGuiOverride else l=(h=='center'and ag.container.
TopbarCentered)or ag.container.TopbarStandard local m=l.Holders k=m[i]end if not
g then self.originalAlignment=i end local m=self.joinedFrame self.screenGui=l
self.alignmentHolder=k if not self.isDestroyed then self.widget.Parent=m or k
end self.alignment=i self.alignmentChanged:Fire(i)ag.iconChanged:Fire(self)
return self end ag.setAlignment=ag.align function ag:setLeft()self:setAlignment
'Left'return self end function ag:setMid()self:setAlignment'Center'return self
end function ag:setRight()self:setAlignment'Right'return self end function ag:
setWidth(f,g)self:modifyTheme{'Widget','DesiredWidth',f,g}return self end
function ag:setImageScale(f,g)self:modifyTheme{'IconImageScale','Value',f,g}
return self end function ag:setImageRatio(f,g)self:modifyTheme{'IconImageRatio',
'AspectRatio',f,g}return self end function ag:setTextSize(f,g)self:modifyTheme{
'IconLabel','TextSize',f,g}return self end function ag:setTextFont(f,g,h,i)g=g
or Enum.FontWeight.Regular h=h or Enum.FontStyle.Normal local j,k=(typeof(f))if
j=='number'then k=Font.fromId(f,g,h)elseif j=='EnumItem'then k=Font.fromEnum(f)
elseif j=='string'then if not f:match'rbxasset'then k=Font.fromName(f,g,h)end
end if not k then k=Font.new(f,g,h)end self:modifyTheme{'IconLabel','FontFace',k
,i}return self end function ag:setTextColor(f,g)if f==nil or f==''or(type(f)~=
'userdata'or typeof(f)~='Color3')then if f~=nil and f~=''then warn
[[setTextColor item must be a Color3 value! Changed the color to white.]]end f=
Color3.fromRGB(255,255,255)end self:modifyTheme{'IconLabel','TextColor3',f,g}
return self end function ag:bindToggleItem(f)if not f:IsA'GuiObject'and not f:
IsA'LayerCollector'then error
'Toggle item must be a GuiObject or LayerCollector!'end self.toggleItems[f]=true
self:_updateSelectionInstances()return self end function ag:unbindToggleItem(f)
self.toggleItems[f]=nil self:_updateSelectionInstances()return self end function
ag:_updateSelectionInstances()for f,g in pairs(self.toggleItems)do local h={}for
i,j in pairs(f:GetDescendants())do if(j:IsA'TextButton'or j:IsA'ImageButton')and
j.Active then table.insert(h,j)end end self.toggleItems[f]=h end end function ag
:_setToggleItemsVisible(f,g,h)for i,j in pairs(self.toggleItems)do if not h or h
==self or h.toggleItems[i]==nil then local k='Visible'if i:IsA'LayerCollector'
then k='Enabled'end i[k]=f end end end function ag:bindEvent(f,g)local h=self[f]
assert(h and typeof(h)=='table'and h.Connect,
'argument[1] must be a valid topbarplus icon event name!')assert(typeof(g)==
'function','argument[2] must be a function!')self.bindedEvents[f]=h:Connect(
function(...)g(self,...)end)return self end function ag:unbindEvent(f)local g=
self.bindedEvents[f]if g then g:Disconnect()self.bindedEvents[f]=nil end return
self end function ag:bindToggleKey(f)assert(typeof(f)=='EnumItem',
'argument[1] must be a KeyCode EnumItem!')self.bindedToggleKeys[f]=true self.
toggleKeyAdded:Fire(f)self:setCaption'_hotkey_'return self end function ag:
unbindToggleKey(f)assert(typeof(f)=='EnumItem',
'argument[1] must be a KeyCode EnumItem!')self.bindedToggleKeys[f]=nil return
self end function ag:call(f,...)local g=table.pack(...)task.spawn(function()f(
self,table.unpack(g))end)return self end function ag:addToJanitor(f,g,h)self.
janitor:add(f,g,h)return self end function ag:lock()local f=self:getInstance
'ClickRegion'f.Visible=false self.locked=true return self end function ag:unlock
()local f=self:getInstance'ClickRegion'f.Visible=true self.locked=false return
self end function ag:debounce(f)self:lock()task.wait(f)self:unlock()return self
end function ag:autoDeselect(f)if f==nil then f=true end self.
deselectWhenOtherIconSelected=f return self end function ag:oneClick(f)local g=
self.singleClickJanitor g:Cleanup()if f or f==nil then g:add(self.selected:
Connect(function()self:deselect('OneClick',self)end))end self.oneClickEnabled=
true return self end function ag:setCaption(f)if f=='_hotkey_'and(self.
captionText)then return self end local g=self.captionJanitor self.captionJanitor
:Cleanup()if not f or f==''then self.caption=nil self.captionText=nil return
self end local h=g:add(a.p()(self))h:SetAttribute('CaptionText',f)self.caption=h
self.captionText=f return self end function ag:setCaptionHint(f)assert(typeof(f)
=='EnumItem','argument[1] must be a KeyCode EnumItem!')self.fakeToggleKey=f self
.fakeToggleKeyChanged:Fire(f)self:setCaption'_hotkey_'return self end function
ag:leave()local f=self.joinJanitor f:Cleanup()return self end function ag:
joinMenu(f)ac.joinFeature(self,f,f.menuIcons,f:getInstance'Menu')f.
menuChildAdded:Fire(self)return self end function ag:setMenu(f)self.menuSet:
Fire(f)return self end function ag:setFixedMenu(f)self:freezeMenu(f)self:
setMenu(f)end ag.setFrozenMenu=ag.setFixedMenu function ag:freezeMenu()self:
select('FrozenMenu',self)self:bindEvent('deselected',function(f)f:select(
'FrozenMenu',self)end)self:modifyTheme{'IconSpot','Visible',false}end function
ag:joinDropdown(f)f:getDropdown()ac.joinFeature(self,f,f.dropdownIcons,f:
getInstance'DropdownScroller')f.dropdownChildAdded:Fire(self)return self end
function ag:getDropdown()local f=self.dropdown if not f then f=a.q()(self)self.
dropdown=f self:clipOutside(f)end return f end function ag:setDropdown(f)self:
getDropdown()self.dropdownSet:Fire(f)return self end function ag:clipOutside(f)
local g=ac.clipOutside(self,f)self:refreshAppearance(f)return self,g end
function ag:setIndicator(f)local g=self.indicator if not g then g=self.janitor:
add(a.r()(self,ag))self.indicator=g end self.indicatorSet:Fire(f)end function ag
:convertLabelToNumberSpinner(f,g)task.defer(function()local h=self:getInstance
'IconLabel'h.Transparency=1 f.Parent=h.Parent f.Size=UDim2.fromScale(1,1)f.
AnchorPoint=Vector2.new(0.5,0.5)f.Position=UDim2.new(0.5,0,0.5,0)f.
TextXAlignment=Enum.TextXAlignment.Center f.ClipsDescendants=false local i={
'FontFace','BorderSizePixel','BorderColor3','Rotation','TextStrokeTransparency',
'TextStrokeColor3','TextStrokeTransparency','TextColor3'}for j,k in ipairs(i)do
f[k]=h[k]self:addToJanitor(h:GetPropertyChangedSignal(k):Connect(function()f[k]=
h[k]end))end local j,k,l,m,n=0,8,function()local j,k=0,0 for l,m in f.Frame:
GetChildren()do local n=string.lower(m.Name)if n=='digit'then j+=m.AbsoluteSize.
X k+=1 elseif n=='prefix'or n=='suffix'or n=='comma'then if m.Text~=''then j+=m.
AbsoluteSize.X k+=1 end end end return j,k end,function()local j=h.Parent local
k=j and j.Parent if k==nil then return 0 end if k.IconImage.Visible==true then
return f.Frame.AbsoluteSize.X+h.Parent.Parent.IconImage.AbsoluteSize.X else
return k.AbsoluteSize.X end end,function()return f.Frame.AbsoluteSize.X end
local o=function()local o,p=l()if p<18 then self:setLabel(f.Value)end local q=n(
)while o<q and self.isDestroyed~=true do task.wait(0.05)if p>j and p<k then f.
TextSize=h.TextSize break else f.TextSize+=1 end q=n()o,p=l()end local r=m()
while o>r and self.isDestroyed~=true do task.wait(0.05)if p<k and p>j then f.
TextSize=h.TextSize break else f.TextSize-=1 end r=m()o,p=l()end end self:
addToJanitor(f.Frame.ChildAdded:Connect(o))self:addToJanitor(f.Frame.
ChildRemoved:Connect(o))self:addToJanitor(self.iconAdded:Connect(function()task.
wait(1)o()end))self:updateParent()f.Name='LabelSpinner'f.Prefix='$'f.Commas=true
f.Decimals=0 f.Duration=0.25 f.Value=10 task.wait(0.2)if typeof(g)=='function'
then g()end end)return self end function ag:destroy()if self.isDestroyed then
return end self:clearNotices()if self.parentIconUID then self:leave()end self.
isDestroyed=true self.janitor:Destroy()ag.iconRemoved:Fire(self)end ag.Destroy=
ag.destroy return ag::StaticIcon__DARKLUA_TYPE_m
