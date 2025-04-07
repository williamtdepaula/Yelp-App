//
//  BusinessCard.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

struct BusinessCard: View {
    let business: Business
    
    private let imageSize: CGSize = .init(width: 120, height: 120)
    
    var body: some View {
        ZStack {
            Color.white
                .frame(height: imageSize.height + 16)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)

            HStack(alignment: .center) {
                image
                VStack(alignment: .leading, spacing: 6) {
                    title
                    rating
                    description
                    isOpen
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var image: some View {
        AsyncCachedImage(url: URL(string: business.imageUrl ?? "")) { image in
            image
                .resizable()
        } placeholder: {
            Rectangle()
                .fill(Color.gray)
        }
        .frame(imageSize)
        .scaledToFill()
        .clipped()
        .cornerRadius(6)
    }
    
    var title: some View {
        Group {
            if let businessName = business.name {
                Text(businessName)
                    .lineLimit(1)
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .foregroundColor(.black)
            }
        }
    }
    
    var rating: some View {
        Group {
            if let rating = business.rating {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", rating))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.yellow)
                    if let reviewCount = business.reviewCount {
                        Text("(\(reviewCount)) reviews")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    var description: some View {
        Text(business.descriptionFormatted)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
    }
    
    var isOpen: some View {
        Group {
            if let isClosed = business.isClosed {
                OpenStatus(isOpen: !isClosed)
            }
        }
    }
}

#Preview {
    BusinessCard(
        business: .init(
            id: "1",
            imageUrl: "https://s3-media3.fl.yelpcdn.com/bphoto/AGwRqNUuEZKnlh1ICNcO8Q/o.jpg",
            url: "https://www.yelp.com/biz/sgt-pepperonis-pizza-store-irvine?adjust_creative=-Sh6cRs16Ux9JFFhTDXnQw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=-Sh6cRs16Ux9JFFhTDXnQw",
            name: "Sgt. Pepperoni's Pizza Store",
            reviewCount: 40,
            rating: 4.5,
            isClosed: true,
            price: "$$",
            location: .init(displayAddress: [
                "1641 Edinger Ave",
                "Ste 101",
                "Tustin, CA 92780"])
        )
    )
}
