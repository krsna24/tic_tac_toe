//
//  ViewController.swift
//  TicTacToe
//
//  Created by Krsna on 16/04/24.
//

import UIKit

class ViewController: UIViewController
{
	enum Turn {
		case Player1
		case Player2
	}
	
	@IBOutlet weak var turnLabel: UILabel!
	@IBOutlet weak var a1: UIButton!
	@IBOutlet weak var a2: UIButton!
	@IBOutlet weak var a3: UIButton!
	@IBOutlet weak var b1: UIButton!
	@IBOutlet weak var b2: UIButton!
	@IBOutlet weak var b3: UIButton!
	@IBOutlet weak var c1: UIButton!
	@IBOutlet weak var c2: UIButton!
	@IBOutlet weak var c3: UIButton!
	
	var firstTurn = Turn.Player2
	var currentTurn = Turn.Player2
	
	var Player = "O"
	var Player2 = "X"
	var board = [UIButton]()
	
	var player1Score = 0
	var player2Score = 0
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		initBoard()
	}
	
	func initBoard()
	{
		board.append(a1)
		board.append(a2)
		board.append(a3)
		board.append(b1)
		board.append(b2)
		board.append(b3)
		board.append(c1)
		board.append(c2)
		board.append(c3)
	}

	@IBAction func boardTapAction(_ sender: UIButton)
	{
		addToBoard(sender)
		
		if checkForVictory(Player2)
		{
			player2Score += 1
			resultAlert(title: "Player 2 Win!")
		}
		
		if checkForVictory(Player)
		{
			player1Score += 1
			resultAlert(title: "Player 1 Wins!")
		}
		
		if(fullBoard())
		{
			resultAlert(title: "Draw")
		}
	}
	
	func checkForVictory(_ s :String) -> Bool
	{
		// Horizontal Victory
		if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
		{
			return true
		}
		if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
		{
			return true
		}
		if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
		{
			return true
		}
		
		// Vertical Victory
		if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
		{
			return true
		}
		if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
		{
			return true
		}
		if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
		{
			return true
		}
		
		// Diagonal Victory
		if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
		{
			return true
		}
		if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
		{
			return true
		}
		
		return false
	}
	
	func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
	{
		return button.title(for: .normal) == symbol
	}
	
	func resultAlert(title: String)
	{
		let message = "\nPlayer1 " + String(player1Score) + "\n\nPlayer2 " + String(player2Score)
		let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
			self.resetBoard()
		}))
		self.present(ac, animated: true)
	}
	
	func resetBoard()
	{
		for button in board
		{
			button.setTitle(nil, for: .normal)
			button.isEnabled = true
		}
		if firstTurn == Turn.Player1
		{
			firstTurn = Turn.Player2
			turnLabel.text = Player2
		}
		else if firstTurn == Turn.Player2
		{
			firstTurn = Turn.Player1
			turnLabel.text = Player
		}
		currentTurn = firstTurn
	}
	
	func fullBoard() -> Bool
	{
		for button in board
		{
			if button.title(for: .normal) == nil
			{
				return false
			}
		}
		return true
	}
	
	func addToBoard(_ sender: UIButton)
	{
		if(sender.title(for: .normal) == nil)
		{
			if(currentTurn == Turn.Player1)
			{
				sender.setTitle(Player, for: .normal)
				currentTurn = Turn.Player2
				turnLabel.text = Player2
			}
			else if(currentTurn == Turn.Player2)
			{
				sender.setTitle(Player2, for: .normal)
				currentTurn = Turn.Player1
				turnLabel.text = Player
			}
			sender.isEnabled = false
		}
	}
	
}

