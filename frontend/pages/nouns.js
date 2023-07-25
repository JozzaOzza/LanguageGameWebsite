import NavBar from "../components/navbar"
import Session from "../components/session"

function Nouns() {

    const topics = [[
        { name: "body", id: 1 }, { name: "conversation", id: 2 }, { name: "creatures", id: 3 },
        { name: "food", id: 4 }, { name: "general", id: 5 }, { name: "leisure", id: 6 },
        { name: "life", id: 7 }, { name: "nature", id: 8 }, { name: "people", id: 9 },
        { name: "places", id: 10 }, { name: "society", id: 11 }, { name: "time", id: 12 },
        { name: "travel", id: 14 }, { name: "work", id: 15 },
    ], "nouns"]

    return (
        <div className="nouns" >
            <NavBar></NavBar>
            <div>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Nouns