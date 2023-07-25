import NavBar from "../components/navbar"
import Session from "../components/session"

function Adjectives() {

    const topics = [[
        { name: "numbers", id: 1 }, { name: "quality", id: 2 }, { name: "possessive", id: 3 },
        { name: "personal", id: 4 }, { name: "colour", id: 5 }, { name: "physical", id: 6 },
        { name: "time", id: 7 }, { name: "indefinite articles", id: 8 }, { name: "nationality", id: 9 }
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