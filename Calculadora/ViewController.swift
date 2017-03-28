//
//  ViewController.swift
//  Calculadora
//
//  Created by User on 3/27/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var primerValor : String = "0"
    var segundoValor : String = "0"
    var decimalAgregado  = false;
    var segundoValorAgregado = false;
    
    enum Operador{
        case SUMA,RESTA,DIVICION,MULTIPLICACION,TERMINAR, NONE
    }
    
    var operador : Operador = Operador.NONE
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var tfResultado: UITextField!
    
    
    //cada boton le asignamos un tag 0-10 (10 es el punto)
    @IBAction func btnNumberTapped(_ sender: UIButton) {
        print("buton clicked : \(sender.tag)")
        sender.setTitleColor(UIColor.blue, for: UIControlState.selected)
        
        if operador == .NONE {
            formatNumber(number: sender.tag, indice : 1)
        }
        else {
            formatNumber(number: sender.tag, indice : 2)
        }
        
        
    }
    
    func formatNumber(number:Int, indice:Int){
        var xValor = "";
        if indice == 1{ xValor = primerValor; }
        else{ xValor = segundoValor; }
        
        if (xValor == "0" && number == 10) {
            xValor = "0.";
            decimalAgregado = true;
            return;
        }else if (xValor == "0" && number == 0){
            return;
        }
        
        //si no es el digito "."
        if (number != 10){
            if (xValor == "0"){ xValor = ""; }
            xValor = xValor + "\(number)"
        }else{
            if (!decimalAgregado){
                decimalAgregado = true;
                xValor = xValor + ".";
            }
        }
        tfResultado.text = xValor;
        
        if indice == 1{ primerValor = xValor; }
        else{ segundoValor = xValor;segundoValorAgregado = true; }
        
    }
    
    func formatFirstNumber(number:Int){
        
        //manejamos los . decimales y los 0's
        if (primerValor == "0" && number == 10) {
            primerValor = "0.";
            decimalAgregado = true;
            return;
        }else if (primerValor == "0" && number == 0){
            return;
        }
        
        //si no es el digito "."
        if (number != 10){
            if (primerValor == "0"){ primerValor = ""; }
            primerValor = primerValor + "\(number)"
        }else{
            if (!decimalAgregado){
                decimalAgregado = true;
                primerValor = primerValor + ".";
            }
        }
        tfResultado.text = primerValor;
    }
    
    func formatSecondNumber(number:Int){
        //manejamos los . decimales y los 0's
        if (segundoValor == "0" && number == 10) {
            segundoValor = "0.";
            decimalAgregado = true;
            return;
        }else if (segundoValor == "0" && number == 0){
            return;
        }
        
        //si no es el digito "."
        if (number != 10){
            if (segundoValor == "0"){ segundoValor = ""; }
            segundoValor = segundoValor + "\(number)"
        }else{
            if (!decimalAgregado){
                decimalAgregado = true;
                segundoValor = segundoValor + ".";
            }
        }
        tfResultado.text = segundoValor;
        segundoValorAgregado = true;
    }
    
    
    //Tags : %0, x1, -2, +3, =4
    @IBAction func operadorClicked(_ sender: UIButton) {
        
        if (sender.tag == 4 && segundoValorAgregado == false) {return;}
        
        if (segundoValorAgregado != true){
            setOperadorSeleccionado(numOperador: sender.tag);
            decimalAgregado = false;
        }else{
            terminaOp();
        }
        
    }
    
    func setOperadorSeleccionado(numOperador : Int){
        switch numOperador {
           case 0: operador = .DIVICION;
           case 1: operador = .MULTIPLICACION;
           case 2: operador = .RESTA;
           case 3: operador = .SUMA;
           default : operador = .TERMINAR;
        }
    }
    
    func terminaOp(){
        print("res = \(primerValor) <<\(operador)>> \(segundoValor)");
        let val1 = Double (primerValor)!
        let val2 = Double (segundoValor)!
        
        var resultado : Double = 0;
        
        switch operador {
        case .DIVICION: resultado = (val1/val2);
        case .MULTIPLICACION: resultado = val1 * val2;
        case .SUMA: resultado = val1 + val2;
        case .RESTA: resultado = val1 - val2;
        default: return;
        }
        
        tfResultado.text = "\(resultado)";
        
        
        operador = Operador.NONE;
        //estadoOperacion = EstadoOperacion.CAPTURA_PRIMER_NUMERO;
        segundoValorAgregado = false;
        primerValor = "0"
        segundoValor = "0"
        decimalAgregado = false
    }

}

