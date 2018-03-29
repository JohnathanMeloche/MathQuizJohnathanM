-- This program generates random numbers 
-- then it asks the user a random math question
-- and finally then displays if they got it right or wrong
-- Johnathan M ICS20
-- Numeric Text Fields

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

  -------------------
--| Local Variables |
  -------------------
--loads Ting sound effect
local Ting = audio.loadSound("Sounds/ding.mp3")
--channel for Ting
local playTing
--params for TIng Sound
local optionsTing = 
{
	channel = 1,
	duration = 1000
}
audio.setVolume ( 1, optionsTing)

local correctSoundFile = audio.loadSound("Sounds/correct.mp3")
local playCorrectSound
local optionsCorrect = 
{
	channel = 3,
	duration = 1000
}
audio.setVolume ( 1, "optionsCorrect" )
local incorrectSoundFile = audio.loadSound("Sounds/incorrect.mp3")
local playIncorrectSound
local optionsIncorrect = 
{
	channel = 4,
	duration = 1000
}
audio.setVolume ( 1, "optionsIncorrect" )
local WinFile = audio.loadSound("Sounds/win.mp3")
local playWin
local optionsWin = 
{
	channel = 5,
	duration = 50000
}
audio.setVolume ( 0.35, "optionsWin" )



--loads background music file
local backgroundMusic = audio.loadSound ("Sounds/Party.mp3")
-- create channel for background music
local backgroundMusicChannel
--sets params for background music
local optionsbackgroundMusic =
{
	channel = 2
}
audio.setVolume ( 0.35, "optionsbackgroundMusic" )
	backgroundMusicChannel = audio.play (backgroundMusic)


--background image
local backgroundImage = display.newImageRect("Images/background.jpg", 1920, 1920)

	--centers the background image
	backgroundImage.x = display.contentWidth/2
	backgroundImage.y = display.contentWidth/2

--background rectangle image
local backgroundrect = display.newImageRect("Images/rectblue.jpg", 1950, 600)
	
	--properties of backgroundrect
	backgroundrect.x = display.contentWidth/2
	backgroundrect.y = 1170
	backgroundrect.strokeWidth = 30
	backgroundrect:setStrokeColor(1, .5, 0)

-- text that shows when redbutton has been clicked or touched
local clicktext = display.newText("Correct!", 500, 500, "Images/vinet.ttf", 140)
	clicktext.isVisible = false
	clicktext:setFillColor(0, 1, 1)

--local particles = require("particles")

local pex = require "pony.com.ponywolf.pex"

local incorrectText = display.newText("Incorrect!", 500, 500, "Images/vinet.ttf", 140)
	incorrectText.isVisible = false
	incorrectText:setFillColor(1, 0, 0)
local questionObject
local numericField
local score = 0
local scoreNumber = display.newText("Score:" .. score, 500, 750, "Images/vinet.ttf", 140)
local randomNumber1
local randomNumber2
local randomNumber3
local tempNumber
local userAnswer
local correctAnswer
local totalSeconds = 10
local secondsLeft = 10
local clockText = display.newText(secondsLeft, -250, 200, "Images/vinet.ttf", 140)
local countDownTimer
local lives = 4
local gameOver = display.newImageRect("Images/gameOver.png", 1920, 1800)
	gameOver.x = display.contentWidth/2
	gameOver.y = display.contentWidth*2/3
	gameOver.isVisible = false




local particle = pex.load("Images/particle.pex", "Images/texture.png")


local heart4 = display.newEmitter(particle)
	heart4.x = 400
	heart4.y = 150
	heart4.isVisible = true

local heart1 = display.newEmitter(particle)
	heart1.x = 1300
	heart1.y = 150
	heart1.isVisible = true

local heart2 = display.newEmitter(particle)
	heart2.x = 1000
	heart2.y = 150
	heart2.isVisible = true

local heart3 = display.newEmitter(particle)
	heart3.x = 700
	heart3.y = 150
	heart3.isVisible = true


-- sets emitter parameters
local emitterparams = {
    startColorAlpha = 1,
    startParticleSizeVariance = 53.47,
    startColorGreen = 0.3031555,
    yCoordFlipped = -1,
    blendFuncSource = 770,
    rotatePerSecondVariance = 153.95,
    particleLifespan = 0.7237,
    tangentialAcceleration = -144.74,
    finishColorBlue = 0,
    finishColorGreen = 0,
    blendFuncDestination = 1,
    startParticleSize = 80,
    startColorRed = 1,
    textureFileName = "Images/fire.png",
    startColorVarianceAlpha = 1,
    maxParticles = 450,
    finishParticleSize = 500,
    duration = -1,
    finishColorRed = 1,
    maxRadiusVariance = 72.63,
    finishParticleSizeVariance = 64,
    gravityy = -200,
    speedVariance = 90.79,
    tangentialAccelVariance = -92.11,
    angleVariance = -142.62,
    angle = -244.11
}
 
-- Create the emitter
local firemitter = display.newEmitter(emitterparams)
 
-- Center the emitter within the content area
	firemitter.x = 813
	firemitter.y = 1200
	firemitter.isVisible = true

local function AskQuestion()

	randomNumber1 = math.random(1, 15)
	randomNumber2 = math.random(1, 15)
	randomNumber3 = math.random(1, 4)

	if (randomNumber2 > randomNumber1) then

		tempNumber = randomNumber1
		randomNumber1 = randomNumber2
		randomNumber2 = tempNumber
	end

	if (randomNumber3 == 1) then

		correctAnswer = randomNumber1 + randomNumber2

		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = " 

	elseif (randomNumber3 == 2) then

		correctAnswer = randomNumber1 * randomNumber2

		questionObject.text = randomNumber1 .. " x " .. randomNumber2 .. " = " 

	elseif (randomNumber3 == 3) then

		correctAnswer = randomNumber1 - randomNumber2

		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = " 

	end

end

local function HideCorrect()
	clicktext.isVisible = false
	AskQuestion()

end

local function HideIncorrect()
	incorrectText.isVisible = false
	AskQuestion()

end

local function UpdateTime()

	secondsLeft = secondsLeft -1

	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then

		secondsLeft = totalSeconds

		lives = lives -1

		if (lives == 3) then
			heart4.isVisible = false
			AskQuestion()
		elseif (lives == 2) then
			heart3.isVisible = false
			AskQuestion()
		elseif (lives == 1) then
			heart2.isVisible = false
			AskQuestion()
		elseif (lives == 0) then
			heart1.isVisible = false
			AskQuestion().
		elseif (lives == -1) then
			gameOver.isVisible = true
			numericField.isVisible = false
			questionObject.isVisible = false
			firemitter.isVisible = false
			scoreNumber.isVisible = false

		end

	end

end

local function StartTimer()

	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)

end

local function NumericFieldListener (event)

	if (event.phase == "began") then

		event.target.text = ""

	elseif (event.phase == "submitted") then

		userAnswer = tonumber(event.target.text)

		if (userAnswer == correctAnswer) then

			clicktext.isVisible = true

			playCorrectSound = audio.play(correctSoundFile)

			timer.performWithDelay(2000, HideCorrect)

			event.target.text = ""

			secondsLeft = totalSeconds

		end

		if (userAnswer ~= correctAnswer) then

			incorrectText.isVisible = true

			event.target.text = ""

			playIncorrectSound = audio.play(incorrectSoundFile)

			timer.performWithDelay(2000, HideIncorrect)

			secondsLeft = 1

		end

	end

end

local function UpdateScore(event)

	if (userAnswer == correctAnswer) then

		score = score +1

	end

	if (score == 10) then
		playWin = audio.play(WinFile)

	end

end




questionObject = display.newText( "", 200, 1200, "Images/vinet.ttf", 140)
	questionObject:setTextColor(1, .2, 1)

numericField = native.newTextField( 800, 1200, 200, 100)
	numericField.inputType = "number"
	numericField:addEventListener( "userInput", NumericFieldListener)


-- event listeners 
AskQuestion()
StartTimer()
UpdateScore()
Runtime:addEventListener ("enterFrame", NumericFieldListener)


