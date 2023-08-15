import NavBar from "../components/navbar"
import Session from "../components/session"

function Adverbs() {

    // take all ones in 'standard' and put into actual categories
    // miscellaneous might better be used in 'other' page
    const topics = [[
        { name: "manner", id: 1 }, { name: "time", id: 2 }, { name: "place", id: 3 },
        { name: "degree", id: 4 }
    ], "adverbs"]

    return (
        <div className="adverbs" >
            <NavBar></NavBar>
            <div>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Adverbs