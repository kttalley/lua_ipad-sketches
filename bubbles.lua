-- Bubbles
Bubbles = class()

function Bubbles:init(x, y)
    self.x = x
    self.y = y
    self.bubbles = {}
    self.maxbubbles = 1000
    self.bubblecount = 0
end

function Bubbles:emit()
    --cap bubble amount on screen--
    if self.bubblecount < self.maxbubbles then
        local dir = vec2(0,1):rotate(math.random() - 0.5) * math.random(1,6)
        local size = math.random(10, 50)
        local life =  math.random(30, 60)
        local bubble = {
            pos = vec2(self.x, self.y),
            dir = dir,
            size = size,
            life = life
        }
        table.insert(self.bubbles, bubble)
        
        self.bubblecount = self.bubblecount+1
    end
end

function Bubbles:update()
    for k,v in pairs(self.bubbles) do
        v.pos = v.pos + v.dir
        v.life = v.life - 1
        
        if v.life == 0 then
            self.bubbles[k] = nil
            self.bubbleount = self.bubblecount -1
        end
    end
end

function Bubbles:draw()
    pushStyle()
    
    --ellipseMode(CENTER)
    --stroke(math.random(100,255))
    --strokeWidth(2)
    --fill(154,197,255,150,255)
    
    for k,v in pairs(self.bubbles) do 
        ellipseMode(CENTER)
        stroke(200,255,255,200)
        strokeWidth(2)
        fill(154,197,255,150)
        ellipse(v.pos.x, v.pos.y, v.size*0.75)
        
         
        --stroke(200,255,255,200)
        --strokeWidth(2)
        noStroke()
        fill(154,197,255,150)
        ellipse(v.pos.x, v.pos.y, v.size*1.2)
        fill(154,197,255,90)
        ellipse(v.pos.x, v.pos.y, v.size*1.8)
        fill(154,197,255,50)
        ellipse(v.pos.x, v.pos.y, v.size*2.2)
    end
    
    popStyle()
end


-- Use this function to perform your initial setup
function setup()
displayMode(FULLSCREEN)
    
    emitter = Bubbles(0,0)
    
end

-- This function gets called once every frame
function draw()
        background(40,40,50)
        strokeWidth(5)
    
        fill(255)
    textAlign(CENTER)
    text("draw something", WIDTH/2, HEIGHT - layout.safeArea.top - 18)
    
    emitter:update()
    emitter:draw() 
end

function touched(touch)
    
    emitter.x = touch.x
    emitter.y = touch.y
    emitter:emit()
end

