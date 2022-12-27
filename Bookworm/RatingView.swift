//
//  RatingView.swift
//  Bookworm
//
//  Created by Arthur Sh on 09.12.2022.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label = ""
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow

    
    var body: some View {
        HStack{
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<5 + 1) { number in
                image(for: number)
                //1.2..currRating 3 will be onColor 4,5 will be offColor
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) starts")
        .accessibilityAdjustableAction { direction in
            switch direction{
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1}
            default:
                break
            }
        }
    }
    
    func image(for number: Int) -> Image {
        //if rating is 3 and in forEach 5 numbers, all after 3 will be offImages(+)
        if number > rating {
            return offImage ?? onImage
            //otherwise all are onImages(stars)
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
