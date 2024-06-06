//
//  ImmersiveView.swift
//  WallArt
//
//  Created by Janvi Arora on 06/06/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    private static let planeX: Float = 3.75
    private static let planeZ: Float = 2.625

    @State var characterEntity: Entity = {
        let headAnchor = AnchorEntity(.head)
        headAnchor.position = [0.70, -0.35, -1]

        let radians = -30 * Float.pi / 180
        ImmersiveView.rotateEntityAroundYAxis(entity: headAnchor, angle: radians)

        return headAnchor
    }()

    @State var planeEntity: Entity = {
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2<Float>(0.6, 0.6)))
        let planeMesh = MeshResource.generatePlane(width: Self.planeX, depth: Self.planeZ, cornerRadius: 0.1)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [ImmersiveView.loadImageMaterial(imageUrl: "think_different")])
        planeEntity.name = "canvas"
        wallAnchor.addChild(planeEntity)
        return wallAnchor
    }()

    var body: some View {
        RealityView { content in
            do {
                let immersiveScene = try await Entity(named: "Immersive", in: realityKitContentBundle)
                characterEntity.addChild(immersiveScene)
                content.add(characterEntity)
                content.add(planeEntity)
            } catch {

            }
        }
    }

    static func rotateEntityAroundYAxis(entity: Entity, angle: Float) {
        // Get the current transform of the entity
        var currentTransform = entity.transform

        // Create a quaternion representing a rotation around the Y-axis
        let rotation = simd_quatf(angle: angle, axis: [0, 1, 0])

        // Combine the rotation with the current transform
        currentTransform.rotation = rotation * currentTransform.rotation

        // Apply the new transform to the entity
        entity.transform = currentTransform
    }

    static func loadImageMaterial(imageUrl: String) -> SimpleMaterial {
        do {
            let texture = try TextureResource.load(named: imageUrl)
            var material = SimpleMaterial()
            material.baseColor = MaterialColorParameter.texture(texture)
            return material
        } catch {
            fatalError(String(describing: error))
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}
