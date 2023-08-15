import NavBar from "../components/navbar"
import Session from "../components/session"

function Adjectives() {

    // 'indefinite articles' need to be moved to 'other' page
    // function to deal with categories with whitespace in the name
    const topics = [[
        { name: "numbers", id: 1 }, { name: "quality", id: 2 }, { name: "possessive", id: 3 },
        { name: "personal", id: 4 }, { name: "colour", id: 5 }, { name: "physical", id: 6 },
        { name: "time", id: 7 }, { name: "nationality", id: 8 }
    ], "adjectives"]

    return (
        <div className="adjectives" >
            <NavBar></NavBar>
            <div>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Adjectives