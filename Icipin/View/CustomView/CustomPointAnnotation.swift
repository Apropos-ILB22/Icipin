//
//  CustomAnnotation.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 23/08/22.
//

import SwiftUI
import MapKit

class CustomPointAnnotation : MKPointAnnotation {
    var identifier: UUID?
    var quest: Quest?
    var place: Place?
}
