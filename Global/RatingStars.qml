import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    width: vpx(100)
    height: vpx(20)

    property variant starsMatrix: [
        { source: getStars(0, rating) },
        { source: getStars(1, rating) },
        { source: getStars(2, rating) },
        { source: getStars(3, rating) },
        { source: getStars(4, rating) }
    ]

    function getStars(index, rate) {
        if (rate <= index) {
            return no_star
        }
        else if (rate <= index + 0.5) {
            return half_star
        }
        else {
            return star
        }
    }

    function getBackgroundColor(rate) {
        if (rate < 2.5) {
            return "#B5714B"
        }
        else if (rate < 4) {
            return colorScheme[theme].main
        }
        else {
            return "#FFCE00"
        }
    }

    Component {
        id: no_star
        Item {
            width: vpx(12 * fontScalingFactor)
            height: vpx(12 * fontScalingFactor)
            Text {
                text: glyphs.emptyStar
                anchors.fill: parent
                font {
                    family: glyphs.name
                    pixelSize: parent.height
                }
                color: colorScheme[theme].accentalt
            }
        }
    }

    Component {
        id: half_star
        Item {
            width: vpx(12 * fontScalingFactor)
            height: vpx(12 * fontScalingFactor)
            Text {
                text: glyphs.halfStar
                anchors.fill: parent
                font {
                    family: glyphs.name
                    pixelSize: parent.height
                }
                color: colorScheme[theme].favorite
            }
        }
    }

    Component {
        id: star
        Item {
            width: vpx(12 * fontScalingFactor)
            height: vpx(12 * fontScalingFactor)
            Text {
                text: glyphs.fullStar
                anchors.fill: parent
                font {
                    family: glyphs.name
                    pixelSize: parent.height
                }
                color: colorScheme[theme].favorite
            }
        }
    }

    Rectangle {
        id: rect_stars
        width: rating_stars.width + vpx(10)
        height: rating_stars.height + vpx(5)
        anchors {
            top: rating_stars.top
            topMargin: -vpx(1)
            left: rating_stars.left
            leftMargin: -vpx(3)
        }
        color: colorScheme[theme].background
        //getBackgroundColor(rating)
        // transform: Matrix4x4 {
        //     property real a: 12 * Math.PI / 180
        //     matrix: Qt.matrix4x4(
        //         1,      -Math.tan(a),       0,      0,
        //         0,      1,                  0,      0,
        //         0,      0,                  1,      0,
        //         0,      0,                  0,      1
        //     )
        // }
    }

    Text {
        id: txt_rating
        anchors {
            top: rect_stars.top; topMargin: -vpx(-0)
            left: rect_stars.right; leftMargin: vpx(3)
        
        }
        text: rating
        font {
            family: global.fonts.sans
            pixelSize: vpx(14  * fontScalingFactor)
        }
        color: colorScheme[theme].accent
    }

    Row {
        id: rating_stars
        spacing: vpx(4)
        Repeater {
            model: starsMatrix
            delegate: Loader {
                sourceComponent: modelData.source
                visible: status == Loader.Ready
            }
        }
    }

}