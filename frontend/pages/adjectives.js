import NavBar from "../components/navbar"
import Session from "../components/session"

function Adjectives() {

    const topics = [[{ name: "possessive", id: 1 }, { name: "indefinite articles", id: 2 }, { name: "numbers", id: 3 }], "adjectives"]

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