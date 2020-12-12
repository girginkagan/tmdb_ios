//
//  APIErrorGenerator.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

public class APIErrorGenerator{
    func generateError(error: BaseModelError) -> String{
        var alertText = ""
        if error.errors != nil{
            for errorModel in error.errors!{
                alertText += errorModel.message!
            }
        }
        else if error.message != nil{
            alertText = error.message!
        }
        
        if alertText == ""{
            alertText = "An unknown error occured."
        }
        
        return alertText
    }
}
